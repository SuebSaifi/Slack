class MessagesController < ApplicationController
  include MessagesHelper
  def new
    @message = Message.new
  end

  def edit
  end

  def show
  end

  def create
    @message = current_user.messages.create(
        msg: messages_params[:msg],
        channel_id: messages_params[:channel_id],
        invitation_id: messages_params[:invitation_id],
        attachments: messages_params[:attachments]
      )

    @message.msg = prase_at_mentions(@message.msg)

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
    params.require(:message).permit(:msg,:channel_id,:invitation_id, attachments: [])
  end
end
