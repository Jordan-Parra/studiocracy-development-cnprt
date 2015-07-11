class CommentVotesController < ApplicationController
	before_filter :authenticate_user!

	def create
		@comment_vote = CommentVote.where(:comment_id => params[:comment_vote][:comment_id], :user_id => current_user.id).first
		if @comment_vote
			@comment_vote.state = params[:comment_vote][:state]
			@comment_vote.save
		else
			@comment_vote = current_user.comment_votes.create(comment_vote_params)
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

	def comment_vote_params
		params.require(:comment_vote).permit(:state, :user_id, :comment_id, :user)
	end

end
