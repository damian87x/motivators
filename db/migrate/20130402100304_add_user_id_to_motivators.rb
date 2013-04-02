class AddUserIdToMotivators < ActiveRecord::Migration
  def change
    add_column :motivators, :user_id, :integer
    add_index :motivators, :user_id
  end
end
