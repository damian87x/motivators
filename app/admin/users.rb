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
    column "UserName", :name
    column :email
    column "Created", :created_at
    actions do |user|
      link_to "Preview", user_path(user), :class => "member_link"
    end
  end


  show :title => :name do
    panel "User motivators" do
      table_for(user.motivators) do
      column :description
      end
    active_admin_comments
  end
end

  sidebar "User Details", :only => :show do
    attributes_table_for user,  :id, :name, :email, :last_sign_in_at, :last_sign_in_ip, :created_at
  end

end





