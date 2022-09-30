class MessagesController < ApplicationController

  def new
    @message = Message.new
  end

  def edit
  end

  def show
  end

  def create
    # debugger
    # @channel = Channel.find(params[:id])
    @message = Message.create!(messages_params)
    if @message.save
      flash[:notice] = "message"
      # redirect_to @channel
    end
  end

  def update
  end

  def delete
  end

  private

  def messages_params
    params.require(:message).permit(:msg, :user_id, :channel_id)
  end
end
