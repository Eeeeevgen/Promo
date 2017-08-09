ActiveAdmin.register Comment do #, as: "UserComment"
  permit_params :image, :parent, :text
end