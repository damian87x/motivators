ActiveAdmin.register Motivator do
  scope :all, :default => true
  filter :description
  filter :created_at
  filter :image_file_size
  filter :user_id




end
