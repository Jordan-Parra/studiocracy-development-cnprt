class RenameVotesToPostVotes < ActiveRecord::Migration
  def self.up
    rename_table :votes, :post_votes
  end

 def self.down
    rename_table :post_votes, :votes
 end
end
