class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_only, :except => :show
  before_action :correct_user?, :except => [:index]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    unless current_user.admin?
      unless @user == current_user
        raise
        redirect_to :back, :alert => "Access denied."
      end
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(secure_params)
      redirect_to :back, :notice => "User updated."
    else
      redirect_to :back, :alert => "Unable to update user."
    end
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    redirect_to root_path, alert: "User deleted, per your request."
  end

  private

    def admin_only
      unless current_user.admin?
        redirect_to :back, :alert => "Access denied."
      end
    end

    def secure_params
      params.require(:user).permit(:location_id, :email, :role, :cohort_id, :github_login)
      # TODO: determine security needs and whether this is needed.  If not, rename secure_params to params
      # if @user == current_user
      #   params.require(:user).permit(:email)
      # elsif current_user.admin?
      #   params.require(:user).permit(:role)
      # end
    end

end
