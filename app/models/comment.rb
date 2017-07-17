class Comment < ApplicationRecord
  belongs_to :image
  acts_as_tree order: 'created_at'
end
