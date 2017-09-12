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

require 'test_helper'

class ImageTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
