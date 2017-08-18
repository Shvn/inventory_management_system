class UsersController < ApplicationController
  skip_before_action :authenticate_user
  before_action :check_if_already_authenticated

  def new
    @user = User.new
  end

  def create
    default = { is_admin: false }
    @user = User.new(user_params.merge(default))
    save_user
  end

  def new_admin
    @user = User.new
  end

  def create_admin
    default = { is_admin: true }
    @user = User.new(user_params.merge(default))
    save_user
  end

  def allotment
    @allotments = Allotment.find_user_allotments(params[:id]).order_descending
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :mobile, :is_admin)
  end

  def save_user
    if @user.save
      flash.now[:success] = "User successfully created"
      signin @user
      redirect_to root_path
    else
      render 'new'
    end
  end
end
