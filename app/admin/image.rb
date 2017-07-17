ActiveAdmin.register Image do
  scope :uploaded
  scope :accepted
  scope :declined

  config.sort_order = "aasm_state_desc"

  batch_action :destroy do |ids|
    ids.each do |id|
      LeaderboardI::Delete.run(image_id: id)
      Image.find(id).destroy
    end
    redirect_back(fallback_location: admin_images_path)
  end

  member_action :accept, method: :get do
    image = Image.find(params[:id])
    image.accept!
    LeaderboardI::NewImage.run(image_id: image.id, score: image.likes_count)
    redirect_back(fallback_location: admin_images_path)
  end

  member_action :decline, method: :get do
    image = Image.find(params[:id])
    image.decline!
    LeaderboardI::Delete.run(image_id: image.id)
    redirect_back(fallback_location: admin_images_path)
  end

  index do
    selectable_column
    column :id
    column :image do |image|
      link_to (image_tag image.image.thumb.url), admin_image_path(image)
    end
    column "User" do |image|
      User.find(image.user_id).name
    end
    column :likes_count
    column 'State', :aasm_state
    actions defaults: false do |image|

      item "View", admin_image_path(image)
      br
      item "Accept", accept_admin_image_path(image)
      br
      item "Decline", decline_admin_image_path(image)
      br
      item "Delete", admin_image_path(image), method: :delete, "data-confirm" => "Are you sure?"
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
      row :status do |image|
        image.aasm_state.capitalize
      end

      row :admin do
        link_to('Accept', accept_admin_image_path(image)) + " " +
            link_to("Decline", decline_admin_image_path(image)) + " " +
            link_to("Delete", admin_image_path(image), method: :delete, "data-confirm" => "Are you sure?")
      end

    end
  end

  controller do
    def destroy
      image = Image.find(params[:id])
      if image
        LeaderboardI::Delete.run(image_id: image.id)
        image.destroy
      end
      redirect_to admin_images_path
    end
  end
end