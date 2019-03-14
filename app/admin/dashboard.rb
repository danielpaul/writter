ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do
    columns do
      column do
        panel "Recent Users" do
          table_for User.order("id desc").limit(5).each do |_user|
            column(:full_name)    { |user| link_to(user.first_name + " " + user.last_name, admin_user_path(user)) }
            column(:email)    { |user| link_to(user.email, admin_user_path(user)) }
            column(:created_at)    { |user| link_to(user.created_at, admin_user_path(user)) }
          end
        end
      end
    end
    columns do
      column do
        panel "Recent Articles" do
          table_for Article.order("id desc").limit(5).each do |_article|
            column(:title)    { |article| link_to(article.title, admin_article_path(article)) }
            column(:author)    { |article| link_to(article.user_id, admin_user_path(article.user_id)) }
            column(:status) { status_tag 'active', class: 'important', label: 'published'}
          end
        end
      end
    end
  end
end

    # Here is an example of a simple dashboard with columns and panels.
    #
    # columns do
    #   column do
    #     panel "Recent Posts" do
    #       ul do
    #         Post.recent(5).map do |post|
    #           li link_to(post.title, admin_post_path(post))
    #         end
    #       end
    #     end
    #   end

    #   column do
    #     panel "Info" do
    #       para "Welcome to ActiveAdmin."
    #     end
    #   end
    # end
    # content
