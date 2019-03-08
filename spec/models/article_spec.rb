require 'rails_helper'

RSpec.describe Article, type: :model do

  it { is_expected.to validate_presence_of :title }
  it { is_expected.to validate_presence_of :text }
  it { is_expected.to validate_presence_of :user_id }

end
