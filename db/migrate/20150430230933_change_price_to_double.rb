class ChangePriceToDouble < ActiveRecord::Migration
	def self.up
		change_table :posts do |t|
			t.change :price, :decimal
		end
	end
	def self.down
		change_table :posts do |t|
			t.change :price, :integer
		end
	end
end
