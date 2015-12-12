class Api::LoginController < Api::BaseController
  def login
    if current_user?
      respond_with user_path(current_user)
    end
  end

  def create
    respond_with @user = User.authenticate(*session_params.values_at(:email, :password))
  end

  def destroy #####
    respond_with root_path
  end

protected

  def session_params
    params.require(:login).permit(:email, :password)
  end
end
