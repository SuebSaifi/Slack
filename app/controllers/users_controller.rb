class UsersController < ApplicationController
  after_action :set_status
  def show
    @user = User.find(params[:id])
  end
  private

  def set_status
    current_user.update!(status: User.statuses["online"]) if current_user
  end
end
