# == Schema Information
#
# Table name: users
#
#  id                :integer          not null, primary key
#  name              :string
#  email             :string
#  crypted_password  :string
#  password_salt     :string
#  persistence_token :string
#  avatar            :string
#  remote_avatar_url :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  token             :string
#

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
