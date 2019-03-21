# == Schema Information
#
# Table name: articles
#
#  id             :bigint(8)        not null, primary key
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  title          :string           not null
#  text           :string           not null
#  user_id        :bigint(8)
#  hash_id        :string
#  publication_id :bigint(8)
#  privacy        :integer
#

require 'test_helper'

class ArticleTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
