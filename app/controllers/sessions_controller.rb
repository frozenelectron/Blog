class SessionsController < ApplicationController
    before_action :redirect_if_authenticated, only: [:destroy]

    def new

    end

    def create
        @user = User.find_by(email: params[:user][:email].downcase)

        if @user
            if @user.unconfirmed?
                redirect_to new_confirmation_path, alert: "You email address is invalid."
            elsif @user.authenticate(params[:user][:password])
                after_login_path = session[:user_return_to] || root_path
                login @user
                remember(@user) if params[:user][:remember_me] == "1"
                redirect_to after_login_path, notice: "Signed In"
            else
                flash.now[:alert] = "Incorrect email or password."
                render :new, status: :unprocessable_entity
            end
        else
            flash.now[:alert] = "Incorrect email or password."
            render :new, status: :unprocessable_entity
        end
    end

    def destroy
        forget(:current_user)
        logout
        redirect_to root_path, "Signed Out!"
    end

end
