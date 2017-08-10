ActiveAdmin.register Comment do #, as: "UserComment"
  menu priority: 5

  actions :index, :edit, :destroy, :update
  permit_params :image, :parent, :text

  # batch_action :destroy do |ids|
  #   ids.each do |id
  #     |
  #   end
  # end

  # config.filters = false
  filter :image_id, label: "Image ID"
  filter :user

  index do
    selectable_column
    column :id
    column :text, class: "pre-wrap"
    column :image do |comment|
      div do
        link_to (image_tag comment.image.image.thumb.url), admin_image_path(comment.image)
      end
      div do
        "#" + comment.image.id.to_s
      end
    end
    column :user
    column :created_at
    actions
  end

  controller do
    # def destroy
    #   Comments::Destroy.run(comment_id: params[:id])
    # end
  end
end