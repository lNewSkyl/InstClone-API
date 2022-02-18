module Api
  module V1
    class PostsController < ApplicationController
      SUCCESS_STATUS = 'SUCCESS'.freeze
      ERROR_STATUS = 'ERROR'.freeze
      before_action :find_post, only: [:show, :destroy, :update]

      def index
        posts = Post.order('created_at DESC')
        render json: posts, status: :ok
      end

      def show
        render json: @post, status: :ok
      end

      def create
        post = Post.new(post_params)
        if post.save
          render json: post, status: :ok
        else
          render json: post.error, status: :unprocessable_entity
        end
      end

      def destroy
        if @post
          @post.destroy
          render json: { massage: "Post was deleted", posts: Post.order('created_at DESC') }, status: :ok
        else 
          render json: @post, status: :ok
        end
      end

      def update
        if @post
          @post.update(post_params)
          render json: @post, status: :ok
        else
          render json: @post, status: :unprocessable_entity
        end
      end

      private

      def post_params
        params.require(:post).permit(:title, :body, :id, {post_attachment: []})
      end
      
      def find_post
        @post ||= Post.find(params[:id])
        render json: { error: 'Answer not found' } unless @post
      end
    end
  end 
end
