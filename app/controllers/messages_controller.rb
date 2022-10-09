class MessagesController < ApplicationController
  def new
    @message = Message.new
  end

  def edit
  end

  def show
  end

  def create
    @message = current_user.messages.build(msg: messages_params[:msg], channel_id: params[:channel_id])
    if @message.save
      flash[:notice] = "message"
    end
  end

  def update
  end

  def delete
  end

  private

  def messages_params
    params.require(:message).permit(:msg)
  end
end
