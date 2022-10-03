class MessagesController < ApplicationController

  def new
    @message = Message.new
  end

  def edit
  end

  def show
  end

  def create
    # @channel = Channel.find(params[:id])
    @message = Message.create!(messages_params)
    respond_to do |format|
    if @message.save
      flash[:notice] = "message"
      format.turbo_stream do 
        render turbo_stream:[
          turbo_stream.update("new_message",partial: "channels/messages",locals: {message: Message.new}),
          turbo_stream.append("messages",partial: "channels/messages_info",locals: {message: Message.new})
      ]
    end
      # redirect_to @channel
    end
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
