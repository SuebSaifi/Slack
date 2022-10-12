class MessagesController < ApplicationController
  def new
    @message = Message.new
  end

  def edit
  end

  def show
  end

  def create
    @message = current_user.messages.build(msg: messages_params[:msg], channel_id: messages_params[:channel_id], invitation_id: messages_params[:invitation_id], attachements: messages_params[:attachments])
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
    params.require(:message).permit(:msg,:channel_id,:invitation_id, attachements: [])
  end
end
