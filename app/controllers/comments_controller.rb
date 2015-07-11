class CommentsController < ApplicationController
	before_filter :authenticate_user!

	def index
	  @comments = Comment.all
	end

	def create
	  @comment = current_user.comments.create(comment_params)
     	  if @comment.save
  	    	flash[:success] = 'Success'
  	    	redirect_to post_path(Post.find(@comment.post_id))
  	  end
	end

	private

	def comment_params
	  params.require(:comment).permit(:message, :user_id, :post_id, :user)
	end
end
