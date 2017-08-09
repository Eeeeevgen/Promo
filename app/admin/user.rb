ActiveAdmin.register User do
  menu priority: 3

  actions :index, :destroy, :edit

  index do
    selectable_column
    column :id
    column :name
    column :email
    column :created_at
    column :updated_at
    column :avatar do |user|
      link_to user.avatar, user.avatar.url
    end
    column :token
    actions
  end

  config.filters = false
end
