ActiveAdmin.register Image do
  scope("Accepted") { |scope| scope.where(aasm_state: :accepted) }
  scope("Uploaded") { |scope| scope.where(aasm_state: :uploaded) }
  scope("Declined") { |scope| scope.where(aasm_state: :declined) }

  config.sort_order = "aasm_state_desc"

  index do
    column :id
    column :image do |image|
      link_to (image_tag image.image.thumb.url), admin_image_path(image)
    end
    column :user_id
    column :likes_count
    column 'State', :aasm_state
    actions defaults: false do |image|
      a "View", href: admin_image_path(image)
      br
      a "Accept", href: "/admin/images/#{image.id}/accept"
      br
      a "Decline", href: "/admin/images/#{image.id}/decline"
      br
      link_to "Delete", admin_image_path(image), method: :delete, "data-confirm" => "Are you sure?"
    end
  end

  # index as: :table do |image|
  #   column :id
  #   column :image do |image|
  #     link_to (image_tag image.image.thumb.url), admin_image_path(image)
  #   end
  # end

  show do
    attributes_table do
      row :id
      row :user_name do
        image.user.name
      end
      row :created_at
      row :image do |image|
        image_tag image.image.url
      end
      row :admin do
        a 'Accept', href: "/admin/images/#{image.id}/accept"
        a 'Decline', href: "/admin/images/#{image.id}/decline"
        link_to "Delete", admin_image_path(image), method: :delete, "data-confirm" => "Are you sure?"
      end

    end
  end

  controller do
    def accept
      image = Image.find(params[:id])
      image.accept!
      LbNewImage.run(image_id: image.id, score: image.likes_count)
      redirect_back(fallback_location: admin_images_path)
    end

    def decline
      image = Image.find(params[:id])
      image.decline!
      LbDelete.run(image_id: image.id)
      redirect_back(fallback_location: admin_images_path)
    end

    def destroy
      image = Image.find(params[:id])
      if image
        LbDelete.run(image_id: image.id)
        image.destroy
      end
      redirect_to admin_images_path
    end
  end
end