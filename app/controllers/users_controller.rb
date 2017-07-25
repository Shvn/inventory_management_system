class UsersController < ApplicationController
  before_action :find_user, except: [:index, :new, :create]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if request.xhr?
      @user.save
    else
      if @user.save
        flash[:success] = "Successfully created"
        redirect_to @user
      else
        render 'new'
      end
    end
  end

  def show
  end

  def edit
  end

  def update
    if request.xhr?
      @user.update_attributes(user_params)
    else
      if @user.update_attributes(user_params)
        flash[:success] = "Successfully updated"
        redirect_to @user
      else
        render 'edit'
      end
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = "Successfully deleted"
      redirect_to users_path
    else
      flash[:error] = "Error, could not delete"
      redirect_to users_path
    end
  end

  private

  def find_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
