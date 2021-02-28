module Api
  class UsersController < ApplicationController
    wrap_parameters :user, include: [:name, :email, :password, :password_confirmation]

    before_action :require_login, only: [:index, :show, :update, :destroy]
    before_action :require_logout, only: [:create]
    before_action :access_denied_for_other_users, only: [:update, :destroy]

    def index
      users = User.all
      render json: {status: 'SUCCESS', action: action_name, data: users, user: session}
    end

    def show
      user = User.find(params[:id])
      render json: {status: 'SUCCESS', action: action_name, data: user, user: session}
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
      user = User.find(params[:id])
      if user.update(user_params)
        render json: {status: 'SUCCESS', action: action_name, data: user}
      else
        render json: {status: 'ERROR', action: action_name, data: user.errors}
      end
    end

    def destroy
      user = User.find(params[:id])
      user.destroy
      render json: {status: 'SUCCESS', action: action_name, data: user}
    end

    private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
    
    def access_denied_for_other_users
      unless User.find(params[:id]) == current_user
        render_unauthorized
      end
    end
    
  end
end