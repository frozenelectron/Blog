class SessionsController < ApplicationController
  def index
  end

  def new
    @user = User.find_by(email: params[:email])
  end

  def create
    @user = User.find_by(email: params[:email])
    if @user.password.
    session[:user_id] = @user.id
  end
end
