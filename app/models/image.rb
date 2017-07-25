class Image < ApplicationRecord
  include AASM

  paginates_per 6

  mount_uploader :image, ImageUploader

  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  scope :accepted, -> { where(aasm_state: :accepted) }
  scope :uploaded, -> { where(aasm_state: :uploaded) }
  scope :declined, -> { where(aasm_state: :declined) }

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
