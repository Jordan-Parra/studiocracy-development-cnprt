class AddColumnsToPost < ActiveRecord::Migration
  def change
    add_column :users, :slug, :string
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :full_name, :string
    add_index :users, :slug
  end
end
