class AddArtAttributesToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :year_created, :integer
    add_column :posts, :medium, :string
    add_column :posts, :dimension_height, :integer
    add_column :posts, :dimension_width, :integer
    add_column :posts, :measurement, :string
    add_column :posts, :weight_in_pounds, :integer
    add_column :posts, :price, :integer
    add_column :posts, :quantity, :integer
  end
end
