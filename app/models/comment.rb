class Comment < ApplicationRecord
  belongs_to :image
  belongs_to :user
  acts_as_tree order: 'created_at', dependent: :nullify
end
