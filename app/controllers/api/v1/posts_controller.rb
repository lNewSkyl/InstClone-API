module Api
  module V1
    class PostsController < ApplicationController
      SUCCESS_STATUS = 'SUCCESS'.freeze
      ERROR_STATUS = 'ERROR'.freeze

      def index
        posts = Post.order('created_at DESC')
        render json: { status: SUCCESS_STATUS, data: posts }, status: :ok
      end

      def show
        post = Post.find(params[:id])
        render json: { status: SUCCESS_STATUS, data: post }, status: :ok
      end

      def create
        post = Post.new(post_params)
        if post.save
          render json: { status: SUCCESS_STATUS, data: post }, status: :ok
        else
          render json: { status: ERROR_STATUS, data: post.errors }, status: :unprocessable_entity
        end
      end

      def destroy
        post = Post.find(params[:id])
        if post.destroy
          render json: { status: SUCCESS_STATUS, data: post }, status: :ok
        else 
          render json: { status: ERROR_STATUS, data: post }, status: :ok
        end
      end

      def update
        post = Post.find(params[:id])
            if post.update(post_params)
          render json: { status: SUCCESS_STATUS, data: post }, status: :ok
        else
          render json: { status: ERROR_STATUS, data: post }, status: :unprocessable_entity
        end
      end

      private

      def post_params
        params.permit(:title, :body, {post_attachment: []})
      end
      
    end
  end 
end
