class AddApprovedToMotivators < ActiveRecord::Migration
  def change
    add_column :motivators, :approved, :boolean, :default => false
  end
end
