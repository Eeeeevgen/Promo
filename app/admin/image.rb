ActiveAdmin.register Image do
  config.sort_order = "aasm_state_desc"

  index do
    column :id
    column :image do |image|
      image_tag image.image.thumb.url
    end
    column :user_id
    column :likes_count
    column :aasm_state, as: :state
    actions defaults: false do |image|
      a "View", href: admin_image_path(image)
      br
      a "Accept", href: "/admin/images/#{image.id}/accept"
      br
      a "Decline", href: "/admin/images/#{image.id}/decline"
    end

  end

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
      end

    end
  end

  controller do
    def accept
      Image.find(params[:id]).accept!
      redirect_to admin_images_path
    end

    def decline
      Image.find(params[:id]).decline!
      redirect_to admin_images_path
    end
  end

  member_action :lock, method: :put do
    puts 00000000000000
    # resource.lock!
    # redirect_to resource_path, notice: "Locked!"
  end
end
