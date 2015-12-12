class LoginController < ApplicationController
  def login
    if current_user?
      redirect_to user_path(current_user)
    end
  end

  def create
    email, password = session_params.values_at(:email, :password)

    if user = (User.authenticate(email, password)).errors.empty?
      user = User.authenticate(email, password)
      session[:user_id] = user.id
      redirect_to user_path(user), notice: "Welcome, #{user.f_name}!"
    else
      redirect_to root_path, alert: 'Invalid email or password'
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to root_path
  end

protected

  def session_params
    params.require(:login).permit(:email, :password)
  end
end
