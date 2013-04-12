ActiveAdmin.register Motivator do
  scope :all, :default => true
  filter :description
  filter :created_at
  filter :image_file_size
  filter :user_id

=begin
  # gird version of index motivators
  index :as => :grid, :columns => 2 do |motivator|
    div do
      a :href => admin_motivator_path(motivator) do
       image_tag(motivator.image.url(:medium), :height => '240')
      end
      div do
        a truncate(motivator.description), :href => admin_motivator_path(motivator)
      end
    div  do
    link_to "delete",resource_path(motivator.id),:method=>:delete,:confirm=>"are you sure?"
    end
   end
  end
 column "Image" do |event|
    link_to(image_tag(event.image.url(:thumb), :height => '100'), admin_event_path(event))
  end

=end

  index do
    selectable_column
    column "Image" do |motivator|
      link_to(image_tag(motivator.image.url(:medium), :height => '240'), admin_motivator_path(motivator))
    end
    column :description
    column :created_at
    column :image_file_size
    actions
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



