ActiveAdmin.register User do

  filter :name
  filter :email
  filter :created_at
  filter :admin
  scope :all, :default => true

  scope :admins do |user|
    user.where(:admin => true)
  end
  form do |f|
    f.inputs "User" do
      f.input :name
      f.input :email
      f.input :password
      f.input :password_confirmation
      end
    f.actions
  end

  index do
    selectable_column
    column "User Name" do |user|
      link_to user.name, admin_user_path(user)
    end
    column :email
    column "Created", :created_at
    actions do |user|
      link_to "Preview", user_path(user)
    end
  end

  show :title => :name do
    panel "User motivators" do
      table_for(user.motivators) do
        column(:approved) { |motivator| status_tag (motivator.approved ? "True" : "False"), (motivator.approved ? :ok : :error) }
        column "Image" do |motivator|
          link_to(image_tag(motivator.image.url(:medium), :height => '240'), admin_motivator_path(motivator))
        end
        column :description
        column :created_at
        column :image_file_size
     end
    active_admin_comments
  end
end

  sidebar "User Details", :only => :show do
    attributes_table_for user,  :id, :name, :email, :last_sign_in_at, :last_sign_in_ip, :created_at
  end

end