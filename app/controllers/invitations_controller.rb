class InvitationsController < ApplicationController

 before_action :authenticate_user!
 before_action :set_invitation
 after_action :set_status
 after_action :set_offline_status
  def index
    @user = current_user
    @pending = @user.pending_invitations
    # end
    @client = Invitation.all.select{ |m| m.confirmed == true || (m.user_id == @user.id || m.client_id == @user.id)}
  end

  def new
  end

  def show
    @invitation = Invitation.find(params[:id])
    @message = Message.new
    pagy_messages = @invitation.messages.order(created_at: :desc)
    @pagy, messages = pagy(pagy_messages, items: 5)
    @messages = messages.reverse
  end

  def create
    @invitation = current_user.invitations.build(invite_params)
    if @invitation.save
      redirect_to root_path
    else
      render root_path
    end
  end

  def accept
    accept = @invitation.update(invite_params)
    redirect_to root_path
  end

  def destroy
    @invitation = Invitation.find(params[:id])
    @invitation.destroy
    redirect_to root_path
  end

  private

  def invite_params
    params.permit(:client_id,:confirmed)
  end
  
  def set_invitation
    @invitation = Invitation.find(params[:id])
  end

  def set_status
    current_user.update!(status: User.statuses["online"]) if current_user
  end

  def set_offline_status
    current_user.update!(status: User.statuses["offline"]) if !current_user
  end
end
