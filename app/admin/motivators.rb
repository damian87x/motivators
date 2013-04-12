ActiveAdmin.register Motivator do
  scope :all, :default => true
  filter :description
  filter :created_at
  filter :image_file_size
  filter :user_id

  index do
    selectable_column
    column "Image" do |motivator|
      link_to(image_tag(motivator.image.url(:medium), :height => '240'), admin_motivator_path(motivator))
    end
    column :description
    column :created_at
    column :image_file_size
    actions do |motivator|
      link_to "Preview", motivator_path(motivator)
    end
  end


  form  do |f|
    f.inputs "Motivator" do
      f.input :description
      f.input :user_id, :as => :select, :collection => User.all
      f.input :image, :as => :file, :hint => f.template.image_tag(f.object.image.url(:medium))
    end
    f.buttons
  end


  show :title => :description do
    panel "motivator view" do
      div(:id => 'inner') do
        image_tag(motivator.image.url(:large))
      end
      h2  motivator.description,:class => 'center_text'
      active_admin_comments
    end

    end

  sidebar "Motivator Details", :only => :show do
    attributes_table_for motivator,  :description, :created_at, :updated_at, :image_file_name, :image_file_size,
                                     :image_content_type, :image_remote_url
  end

end



