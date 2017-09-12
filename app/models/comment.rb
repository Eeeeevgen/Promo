# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  text       :text
#  image_id   :integer
#  user_id    :integer
#  parent_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Comment < ApplicationRecord
  belongs_to :image
  belongs_to :user
  acts_as_tree order: 'created_at', dependent: :nullify
end
