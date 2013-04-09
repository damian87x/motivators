class AddImageRemoteUrlToMotivators < ActiveRecord::Migration
  def change
    add_column :motivators, :image_remote_url, :string
  end
end
