class CreateMotivators < ActiveRecord::Migration
  def change
    create_table :motivators do |t|
      t.string :description

      t.timestamps
    end
  end
end
