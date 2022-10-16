class ChannelsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_channel
  after_action :set_status
  def index
    if current_user
      @channels = Channel.all
    end
  end

  def new
    @channel = Channel.new
  end

  def edit
  end

  def show
    @channel = Channel.find(params[:id])
    @message = Message.new
    pagy_messages = @channel.messages.order(created_at: :desc)
    @pagy, messages = pagy(pagy_messages, items: 20)
    @messages = messages.reverse
  end

  def create
    @channel = Channel.new(channel_params)
    # debugger
    if @channel.save
      # notice[:flash] = "Channel Has been Created"
      UserChannel.create!(user_id: current_user.id, channel_id: @channel.id)
      current_user.update(role: "Admin_#{@channel.id}")
      redirect_to root_path
    else
      render "new"
    end

  end

  def update
    @channel = Channel.find(params[:id])
    @user = User.find(params[:user_id])
    if !@channel.users.include?(@user)
        @channel.users << @user
    end
  end

  def delete
  end

  def add_user
   
  end

  private

  def set_channel
    # @channel =Channel.find(params[:id])
  end
  def channel_params
     params.require(:channel).permit(:name,:user_id)
  end
  def messages_params
     params.permit(:msg,:user_id, :channel_id)
  end

  def set_status
    current_user.update!(status: User.statuses["online"]) if current_user
  end
end
