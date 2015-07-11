class ChangeVotesToPostVotes < ActiveRecord::Migration
  def change
    remove_column :votes, :up
    remove_column :votes, :comment_id
    add_column :votes, :state, :integer, :after => :post_id
  end
end
