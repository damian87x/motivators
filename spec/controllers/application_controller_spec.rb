def authenticate_admin_user!
  redirect_to new_user_session_path unless user_signed_in? && current_user.admin?
end