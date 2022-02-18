module Api
  module V1
    class LikesController < ApplicationController
      before_action :post
      before_action :find_like, only: [:destroy]
      SUCCESS_STATUS = 'SUCCESS'.freeze
      ERROR_STATUS = 'ERROR'.freeze

      def index
        render json: @post.likes
      end

      def create
        if already_liked?
          render json: { message: "ALREADY LIKED!!!", status: ERROR_STATUS, data: like }, status: :ok
        else
          @post.likes.create(user_id: current_user.id)
          render json: { message: "LIKED!!!", status: SUCCESS_STATUS, data: like }, status: :ok
        end
      end

      def destroy
        if @like.blank?
          render json: { message: "CANNOT UNLIKE!!!", status: ERROR_STATUS, data: @like }, status: :ok
        else
          @like.destroy
          render json: { message: "UNLIKED!!!", status: SUCCESS_STATUS, data: @like }, status: :ok
        end
      end

      private

      def like_params
        params.permit(:post_id)
      end

      def post
        @post ||= Post.find(params[:post_id])
      end

      def already_liked?
        Like.where(user_id: current_user.id, post_id:
        params[:post_id]).exists?
      end

      def find_like
         @like = post.likes.find(params[:id])
      end
    end
  end 
end
