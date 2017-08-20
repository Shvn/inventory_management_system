module SessionsHelper
  def signin(user)
    session[:user_id] = user.id
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def signned_in?
    current_user.present?
  end

  def signout
    session.delete(:user_id)
    @current_user = nil
  end

  def authenticate_user
    redirect_to signin_path unless current_user
  end

  def check_if_already_authenticated
    if signned_in?
      redirect_to root_path
    end
  end

  def is_admin
    @current_user.is_admin
  end

  def check_if_admin
    render 'layouts/admin_authorization' unless is_admin
  end
end
