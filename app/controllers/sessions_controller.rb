class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email])

    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      redirect_to links_path
    else
      flash[:error] = "Invalid login credentials. Nice Try Meeka and Steve."
      redirect_to login_path
    end
  end

  def destroy
    session.clear
    redirect_to login_path
  end
end
