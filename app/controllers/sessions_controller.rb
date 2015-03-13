class SessionsController < ApplicationController
  skip_before_filter :set_current_user
  def create
    auth= request.env["omniauth.auth"]
    user= Employee.find_by_uid( auth["uid"] ) || Employee.create_on_first_login(auth)
    if ( user )
      session[:user_uid] = user.uid
      redirect_to  employees_path
    else
      flash[:notice] =  auth['info']['email'] + " is not registered to an employee "
      redirect_to '/login'
    end
  end

  def logout

  end

  def new
    render "sessions/login"
  end

  def destroy
    session.delete(:user_id)
    flash[:notice] = 'Logged out successfully.'
    redirect_to "/login"
  end
end
