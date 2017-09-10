ActiveAdmin.register Comment do
  menu priority: 5

  actions :index, :edit, :destroy, :update
  permit_params :image, :parent, :text

  filter :image_id, label: proc { I18n.t('active_admin.image_id') }
  filter :user

  index do
    selectable_column
    column :id
    column :text, class: "pre-wrap"
    column :parent do |comment|
      comment.parent.try(:text)
    end
    column :image do |comment|
      div do
        link_to (image_tag comment.image.image.thumb.url), admin_image_path(comment.image)
      end
      div do
        '#' + comment.image.id.to_s
      end
    end
    column :user
    column :created_at
    actions
  end
end