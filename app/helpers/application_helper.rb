module ApplicationHelper
    def dashboard_path_for(user)
        return root_path unless user # fallback if no user logged in

        user.admin? ? admin_dashboard_path : posts_path
    end

    def markdown(text)
        renderer = Redcarpet::Render::HTML.new(
            filter_html: true,
            hard_wrap: true
        )
        markdown = Redcarpet::Markdown.new(renderer, {
            autolink: true,
            tables: true,
            fenced_code_blocks: true,
            strikethrough: true,
            underline: true
        })
        markdown.render(text).html_safe
    end
end
