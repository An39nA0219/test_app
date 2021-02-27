module Api
  class UserSessionsController < ApplicationController

    def create
      email = params[:email].downcase
      password = params[:password]
      if login(email, password)
        render json: { status: 'SUCCESS', data: session, message: 'ログインしました' }
      else
        render json: { status: 'ERROR', message: 'ログインできません' }
      end
    end

    def destroy
      session[:user_id] = nil
      render json: { status: 'SUCCESS', message: 'ログアウトしました' }
    end

    private

    def login(email, password)
      @user = User.find_by(email: email)
      if @user && @user.authenticate(password)
        session[:user_id] = @user.id
        return true
      else
        return false
      end
    end

  end
end