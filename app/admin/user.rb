ActiveAdmin.register User do
  permit_params :admin

  index do
    column :id
    column :name
    column :email
    column :admin
    column :avatar
    actions
  end
end
