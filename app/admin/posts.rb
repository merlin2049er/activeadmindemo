ActiveAdmin.register Post do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

  scope :all
  scope :published
  scope :unpublished


action_item :publish, only: :show do
	link_to "Publish", publish_admin_post_path(post), method: :put if !post.published_at?

end

action_item :publish, only: :show do
	link_to "Unpublish", unpublish_admin_post_path(post), method: :put if post.published_at?

end


permit_params :title, :body, :published_at, :user_id

member_action :publish, method: :put do
	post = Post.find(params[:id])
	post.update(published_at: Time.zone.now)
	redirect_to admin_post_path(post)
end

member_action :unpublish, method: :put do
	post = Post.find(params[:id])
	post.update(published_at: nil)
	redirect_to admin_post_path(post)
end

end
