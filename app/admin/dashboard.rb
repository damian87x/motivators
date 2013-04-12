ActiveAdmin.register_page "Dashboard" do
  menu :priority => 1
  content :title => proc{ I18n.t("active_admin.dashboard") } do
    columns do

      column do
        panel "Last ten motivators" do
          table_for Motivator.limit(10) do
             column(:description)  { |motivator| link_to motivator.description, admin_motivator_path(motivator) }
             column(:created_at)
             column(:user_id) { |motivator|  User.find(motivator.user_id) }
          end
        end

      end

    end
  end

end

