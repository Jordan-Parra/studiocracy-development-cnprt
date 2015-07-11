class PostVotesController < ApplicationController
	before_filter :authenticate_user!

	def create
		@post_vote = PostVote.where(:post_id => params[:post_vote][:post_id], :user_id => current_user.id).first
		if @post_vote
			@post_vote.state = params[:post_vote][:state]
			@post_vote.save
		else
			@post_vote = current_user.post_votes.create(post_vote_params)
		end	
		redirect_to :back
	end

=begin
  	def create_comment_vote
		@comment_vote = Vote.where(:comment_id => params[:vote][:comment_id], :user_id => current_user.id).first
		if @comment_vote
			@comment_vote.up = params[:vote][:up]
			@comment_vote.save
		else
			@comment_vote = current_user.votes.create(vote_params)
		end
		redirect_to :back
	end
=end

	private

	def post_vote_params
		params.require(:post_vote).permit(:state, :user_id, :post_id, :user)
	end

end
