# == Schema Information
#
# Table name: comments
#
#  id               :bigint(8)        not null, primary key
#  commentable_type :string
#  commentable_id   :integer
#  user_id          :integer
#  body             :text
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

require "rails_helper"

RSpec.describe Comment, type: :model do
  it { is_expected.to have_db_column(:commentable_id).of_type(:integer) }
  it { is_expected.to have_db_column(:commentable_type).of_type(:string) }
  it { is_expected.to have_db_column(:body).of_type(:text) }

  it { is_expected.to validate_presence_of :commentable_id }
  it { is_expected.to validate_presence_of :commentable_type }
  it { is_expected.to validate_presence_of :body }
  it { is_expected.to validate_presence_of :user_id }

  it { is_expected.to belong_to(:commentable) }

  it { is_expected.to validate_length_of(:body).is_at_most(1000) }
end
