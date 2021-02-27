module Api
  class PostsController < ApplicationController

    before_action :set_post, only: [:show, :update, :destroy]

    def index
      posts = Post.all
      render json: {status: 'SUCCESS', action: action_name, data: posts}
    end

    def show
      render json: {status: 'SUCCESS', action: action_name, data: @post}
    end

    def create
      post = Post.new(post_params)
      if post.save
        render json: {status: 'SUCCESS', action: action_name, data: post}
      else
        render json: {status: 'ERROR', action: action_name, data: post.errors}
      end
    end

    def update
      if @post.update(post_params)
        render json: {status: 'SUCCESS', action: action_name, data: @post}
      else
        render json: {status: 'ERROR', action: action_name, data: @post.errors}
      end
    end

    def destroy
      @post.destroy
      render json: {status: 'SUCCESS', action: action_name, data: @post}
    end

    private

    def post_params
      params.require(:post).permit(:user_id, :content)
    end

    def set_post
      @post = Post.find(params[:id])
    end
  end
end