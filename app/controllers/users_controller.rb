class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :find_by, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy

  def new
    @user = User.new
  end

  def show
    redirect_to root_url if !@user.present? || !@user.activated?
    @microposts = @user.microposts.paginate page: params[:page]
  end

  def index
    @users = User.sep.paginate page: params[:page]
  end

  def edit; end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = t ".profile"
      redirect_to @user
    else
      render :edit
    end
  end

  def create
    @user = User.new user_params
    if @user.save
      @user.send_activation_mail
      flash[:success] = t ".success"
      redirect_to root_url
    else
      render :new
    end
  end

  def destroy
    @user.destroy
    flash[:success] = t ".delete"
    redirect_to users_url
  end

  private

  def find_by
    @user = User.find_by id: params[:id]
    return if @user
    flash[:danger] = t ".fail_find"
    redirect_to root_path
  end

  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation
  end

  def correct_user
    redirect_to root_url unless current_user? @user
  end

  def admin_user
    redirect_to root_url unless current_user.admin?
  end
end
