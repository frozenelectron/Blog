class RegistrationsController < ApplicationController
include Authentication
    before_action :authenticate_user!, only: [:edit, :destroy, :update]

    def index
        @user = User.new()
        render :new
    end

    def new
        @user = User.new()
    end

    def create
        @user = User.create(create_user_params)
        if @user.save
            login @user
            @user.send_confirmation_email!
            redirect_to root_path, notice: "You've successfully signed up your account! Happy Blogging!"
        else
            render :new, status: :unprocessable_entity
        end
    end

    def destroy
        current_user.destroy
        reset_session
        redirect_to root_path, notice: "Your account has been deleted."
    end

    def edit
        @user = current_user
    end

    def update
        @user = current_user
        if @user.authenticate(params[:user][:current_password])
            if @user.update(update_user_params)
                if params[:user][:unconfirmed_email].present?
                    @user.send_confirmation_email!
                    redirect_to root_path, notice: "Check you email for confirmation instructions."
                else
                    redirect_to rooth_path, alert:"Account updated."
                end
            else
                render :edit, status: :unprocessable_entity
            end
        else
            flash.now[:error] = "Incorrect password"
            render :edit, status: :unprocessable_entity
        end
    end


end
