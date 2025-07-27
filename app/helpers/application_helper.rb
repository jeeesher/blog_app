module ApplicationHelper
    def dashboard_path_for(user)
        return root_path unless user # fallback if no user logged in

        user.admin? ? admin_dashboard_path : posts_path
    end
end
