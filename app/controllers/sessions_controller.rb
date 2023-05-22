class SessionsController < ApplicationController
    before_action :redirect_if_authenticated, only: [:create,:new]

    def new
    
    end

    def create
        @user = User.find_by(email: params[:user][:email].downcase)

        if @user
            if @user.unconfirmed?
                redirect_to new_confirmation_path, alert: "You email address is invalid."
            elsif @user.authenticate(params[:user][:password])
                login @user
                redirect_to root_path, notice: "Signed In"
            else
                flash.now[:alert] = "Incorrect email or password."
            end
        else
            flash.now[:alert] = "Incorrect email or password."
        end
    end
    
    def destroy
        @user = User.find_by(email: params[:user][:email].downcase)

        if @user
            if @user.destroy!
                redirect_to root_path, notice:"Your account is deleted!"



end