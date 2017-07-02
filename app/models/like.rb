class Like < ApplicationRecord
  belongs_to :image, counter_cache: true
end
