module Api
  module V1
    class LikesController < ApplicationController
      SUCCESS_STATUS = 'SUCCESS'.freeze
      ERROR_STATUS = 'ERROR'.freeze

      def show
      end

      def create
        @like = current_user.likes.build(like_params)
        @post = @like.post
        if @like.save
          # respond_to :js
          render json: { massage: "Liked!!!", status: SUCCESS_STATUS, data: @like }, status: :ok
        end
      end

      def destroy
        @like = Like.find_by(id: params[:id])
        @post = @like.post
        if @like.destroy
          # respond_to :js
        render json: { massage: "UNLIKED!!!", status: SUCCESS_STATUS, data: @like }, status: :ok
      end

      private

      def like_params
        params.permit(:post_id)
      end
      

    end
  end 
end
