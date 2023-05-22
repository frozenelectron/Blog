class RegistrationsController < ApplicationController
include Authentication
    def index
        @user = User.new()
        render :new
    end
    
    def new
        @user = User.new()
    end

    def create
        @user = User.create(user_params)
        if @user.save
            @user.send_confirmation_email!
            notice:"You've successfully signed up your account! Happy Blogging!"
        else
            render :new, status: :unprocessable_entity
        end
    end
end
