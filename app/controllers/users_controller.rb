class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :admin_only, :except => :show
  before_action :correct_user?, :except => [:index, :new, :create]

  def index
    @users = User.all
  end

  def show
    unless current_user.admin?
      unless @user == current_user
        raise
        redirect_to :back, :alert => "Access denied."
      end
    end
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    github = params[:user][:github_login]
    role = params[:user][:role]
    cohort = Cohort.find_by_id(params[:user][:cohort_id])
    @user = User.create_from_github(github, params[:role], cohort)
    redirect_to @user
  end

  def update
    if @user.update_attributes(user_params)
      redirect_to :back, :notice => "User updated."
    else
      redirect_to :back, :alert => "Unable to update user."
    end
  end

  def destroy
    @user.destroy
    redirect_to root_path, alert: "User deleted, per your request."
  end

  private

    def set_user
      @user = User.find(params[:id])    
    end

    def admin_only
      unless current_user.admin?
        redirect_to :back, :alert => "Access denied."
      end
    end

    def user_params
      params.require(:user).permit(
        :location_id, :email, :role, :cohort_id, :github_login, :name, :short)
    end

end
