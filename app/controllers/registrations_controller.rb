class RegistrationsController < ApplicationController

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
            redirect_to root_path, notice: "You've successfully signed up your account! Happy Blogging!"
        else
            render :new, status: :unprocessable_entity
        end
    end
end
