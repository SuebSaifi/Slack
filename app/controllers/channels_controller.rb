class ChannelsController < ApplicationController
    before_action :authenticate_user!

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
    @message = Message.create(messages_params)
  end

  def create
    @channel = Channel.new(channel_params)
    # debugger
    if @channel.save
      # notice[:flash] = "Channel Has been Created"
      UserChannel.create!(user_id: current_user.id, channel_id: @channel.id)
      current_user.update(role: "Admin")

      redirect_to root_path
    else
      render "new"
    end

  end

  def update
  end

  def delete
  end

  private

  def channel_params
     params.require(:channel).permit(:name,:user_id)
  end
  def messages_params
     params.permit(:msg,:user_id, :channel_id)
  end
end