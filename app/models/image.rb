class Image < ApplicationRecord
  include AASM

  mount_uploader :image, ImageUploader
  belongs_to :user
  has_many :likes

  aasm :whiny_transitions => false do
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
