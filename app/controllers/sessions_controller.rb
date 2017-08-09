class SessionsController < ApplicationController
  skip_before_action :authenticate_user

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)

    if user
      if user.authenticate(params[:session][:password])
        signin user
        redirect_to root_path
      else
        flash.now[:danger] = 'Invalid password'
        render 'new'
      end
    else
      flash.now[:warning] = 'This user is not registered with us'
      render 'new'
    end
  end

  def destroy
    signout
    redirect_to root_path
  end
end
