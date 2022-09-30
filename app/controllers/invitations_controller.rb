class InvitationsController < ApplicationController

 before_action :authenticate_user!

  def index
    @user = current_user
    @pending = @user.pending_invitations
    # end
    @client = Invitation.all.select{ |m| m.confirmed == true || (m.user_id == @user.id || m.client_id == @user.id)}
  end

  def new
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @invitation = current_user.invitations.create(invite_params)
    if @invitation.save
      redirect_to root_path
    else
      render all_user_path
    end
  end

  def accept
    @invitation = Invitation.find(params[:id])
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
      
    
end
