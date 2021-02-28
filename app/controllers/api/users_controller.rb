module Api
  class UsersController < ApplicationController
    before_action :require_login
    before_action :set_user, only: [:show, :update, :destroy]

    def index
      users = User.all
      render json: {status: 'SUCCESS', action: action_name, data: users, user: session}
    end

    def show
      render json: {status: 'SUCCESS', action: action_name, data: @user}
    end

    def create
      user = User.new(user_params)
      if user.save
        render json: {status: 'SUCCESS', action: action_name, data: user}
      else
        render json: {status: 'ERROR', action: action_name, data: user.errors}
      end
    end

    def update
      if @user.update(user_params)
        render json: {status: 'SUCCESS', action: action_name, data: @user}
      else
        render json: {status: 'ERROR', action: action_name, data: @user.errors}
      end
    end

    def destroy
      @user.destroy
      render json: {status: 'SUCCESS', action: action_name, data: @user}
    end

    private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    def set_user     
      @user = User.find(params[:id])
    end
    
  end
end