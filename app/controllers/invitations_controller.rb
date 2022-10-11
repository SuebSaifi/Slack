class InvitationsController < ApplicationController

 before_action :authenticate_user!
 before_action :set_invitation

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
    @messages = @invitation.messages.order(created_at: :desc)
  end

  def create
    @invitation = current_user.invitations.create(invite_params)
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
    
end
