module Api
  class PostsController < ApplicationController
    before_action :require_login
    before_action :access_denied_for_other_posts, only: [:update, :destroy]
    before_action :set_post, only: [:show, :update, :destroy]

    def index
      posts = Post.all
      render json: {status: 'SUCCESS', action: action_name, data: posts, user: session}
    end

    def show
      render json: {status: 'SUCCESS', action: action_name, data: @post, user: session}
    end

    def create
      post = Post.new(post_params)
      post.user_id = @current_user.id
      if post.save
        render json: {status: 'SUCCESS', action: action_name, data: post, user: session}
      else
        render json: {status: 'ERROR', action: action_name, data: post.errors, user: session}
      end
    end

    def update
      if @post.update(post_params)
        render json: {status: 'SUCCESS', action: action_name, data: @post, user: session}
      else
        render json: {status: 'ERROR', action: action_name, data: @post.errors, user: session}
      end
    end

    def destroy
      @post.destroy
      render json: {status: 'SUCCESS', action: action_name, data: @post, user: session}
    end

    private

    def post_params
      params.require(:post).permit(:content)
    end

    def set_post
      @post = Post.find(params[:id])
    end

    def access_denied_for_other_posts
      unless Post.find(params[:id]).user == current_user
        render_unauthorized
      end
    end
  end
end