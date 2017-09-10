ActiveAdmin.register Image do
  actions :index, :show, :edit

  menu priority: 1

  scope proc{ I18n.t('activerecord.scopes.image.uploaded') }, :uploaded
  scope proc{ I18n.t('activerecord.scopes.image.accepted') }, :accepted
  scope proc{ I18n.t('activerecord.scopes.image.declined') }, :declined

  config.sort_order = 'aasm_state_desc'

  batch_action :destroy do |ids|
    ids.each do |id|

      LeaderboardI::Delete.run(image_id: id)
      Image.find(id).destroy
    end
    redirect_back(fallback_location: admin_images_path)
  end

  member_action :accept, method: :get do
    image = Image.find(params[:id])
    if image.declined?
      Workers::DestroyWorker.run(image_id: image.id)
    end
    image.accept!
    LeaderboardI::NewImage.run(image_id: image.id, score: image.likes_count)

    redirect_back(fallback_location: admin_images_path)
  end

  member_action :decline, method: :get do
    image = Image.find(params[:id])
    image.decline!
    LeaderboardI::Delete.run(image_id: image.id)
    DelayedDeleteWorker.perform_in(Sidekiq::DELAYED_DESTROY_TIME, params[:id])

    redirect_back(fallback_location: admin_images_path)
  end

  filter :user, label: proc { User.model_name.human }
  filter :created_at
  filter :updated_at
  filter :likes_count,  as: :range_select

  index do
    selectable_column
    column :id
    column :image do |image|
      link_to (image_tag image.image.thumb.url), admin_image_path(image)
    end
    column User.model_name.human do |image|
      User.find(image.user_id).name
    end
    column :likes_count
    state_column :aasm_state, states: { Image.human_attribute_name('aasm_state/uploaded') => :uploaded,
                                        Image.human_attribute_name('aasm_state/accepted') => :accepted,
                                        Image.human_attribute_name('aasm_state/declined') => :declined }
    column :created_at
    actions defaults: false, dropdown: true do |image|
      item t('active_admin.view'), admin_image_path(image)
      unless image.accepted?
        item t('active_admin.accept'), accept_admin_image_path(image)
      end
      unless image.declined?
        item t('active_admin.decline'), decline_admin_image_path(image)
      end
        item t('active_admin.delete'), admin_image_path(image), method: :delete, 'data-confirm' => 'Are you sure?'
    end
  end

  show do
    attributes_table do
      row :id
      row I18n.t("active_admin.user_name") do
        image.user.name
      end
      row :created_at
      row :image do |image|
        image_tag image.image.url
      end
      state_row :aasm_state, states: { Image.human_attribute_name('aasm_state/uploaded') => :uploaded,
                                       Image.human_attribute_name('aasm_state/accepted') => :accepted,
                                       Image.human_attribute_name('aasm_state/declined') => :declined }
      row I18n.t('active_admin.time_until_destroyed') do |image|
        if image.declined?
          Workers::GetDestroyTime.run!(image_id: image.id)
        end
      end
      row :likes_count
      row I18n.t('active_admin.leaderboard.rank'), :rank do |image|
        LB.rank_for(image.id)
      end
      row I18n.t("active_admin.actions"), :admin do |image|
        unless image.accepted?
          span do
            link_to t('active_admin.accept'), accept_admin_image_path(image), class: 'custom-button light-button'
          end
        end
        unless image.declined?
          span do
            link_to t('active_admin.decline'), decline_admin_image_path(image), class: 'custom-button light-button'
          end
        end
        span do
          link_to t('active_admin.delete'), admin_image_path(image), method: :delete, 'data-confirm' => 'Are you sure?', class: 'custom-button dark-button'
        end
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
