module Api
  module V1
    class PostsController < ApplicationController
      SUCCESS_STATUS = 'SUCCESS'.freeze
      ERROR_STATUS = 'ERROR'.freeze
      before_action :find_post, only: [:show, :destroy, :update]

      def index
        @posts = Post.order('created_at DESC')
        render json: { status: SUCCESS_STATUS, data: @posts }, status: :ok
      end

      def show
        render json: { status: SUCCESS_STATUS, data: @post }, status: :ok
      end

      def create
        @post = Post.new(post_params)
        if @post.save
          render json: { status: SUCCESS_STATUS, data: @post }, status: :ok
        else
          render json: { status: ERROR_STATUS, data: @post.errors }, status: :unprocessable_entity
        end
      end

      def destroy
        if @post
          @post.destroy
          render json: { data: Post.all, status: SUCCESS_STATUS }, status: :ok
        else 
          render json: { status: ERROR_STATUS, data: @post }, status: :ok
        end
      end

      def update
        if @post
          @post.update(post_params)
          render json: { status: SUCCESS_STATUS, data: @post }, status: :ok
        else
          render json: { status: ERROR_STATUS, data: @post }, status: :unprocessable_entity
        end
      end

      private

      def post_params
        params.permit(
          :title, 
          :body, 
          :id,
          {post_attachment: []}
          )
      end
      
      def find_post
        @post = Post.find(params[:id])
      end
    end
  end 
end
