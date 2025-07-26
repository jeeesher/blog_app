class SessionsController < ApplicationController
  def new
  end

  def create
  user = User.find_by(email: params[:email])

  if user && user.authenticate(params[:password])
    session[:user_id] = user.id
    
    if user.role == "admin"
      redirect_to admin_dashboard_path, notice: "Welcome back, Admin!"
    else
      redirect_to posts_path, notice: "Logged in successfully"
    end

  else
    flash.now[:alert] = "Invalid email or password"
    render :new
  end
end


  def destroy
    session[:user_id] = nil
    flash[:notice] = "Logged out successfully!"
    redirect_to root_path
  end
end
