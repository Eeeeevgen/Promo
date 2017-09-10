# == Schema Information
#
# Table name: images
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  image       :string
#  likes_count :integer          default(0)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  aasm_state  :string           default("uploaded")
#

class Image < ApplicationRecord
  include AASM

  paginates_per 6

  mount_uploader :image, ImageUploader

  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  scope :ordered_by_rating, -> { accepted.sort_by { |image| LB.rank_for(image.id) } }

  aasm whiny_transitions: false do
    state :uploaded, initial: true
    state :accepted
    state :declined

    event :accept do
      transitions from: [:uploaded, :declined], to: :accepted
    end

    event :decline do
      transitions from: [:uploaded, :accepted], to: :declined
    end
  end
end
