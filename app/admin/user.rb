ActiveAdmin.register User do
  menu priority: 3

  actions :index, :destroy, :edit, :update

  permit_params :name, :email, :avatar

  index do
    selectable_column
    column :id
    column :name
    column :email
    column :authorizations do |user|
      ul do
        user.authorizations.each do |auth|
          li do
            auth.provider
          end
        end
      end
    end
    column :created_at
    column :updated_at
    column :avatar do |user|
      image_tag user.avatar.url, size: 50
    end
    actions
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :email
      f.input :avatar
    end
    f.actions
  end

  config.filters = false
end
