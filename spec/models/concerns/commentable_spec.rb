shared_examples "commentable" do
  it { is_expected.to have_many(:comments) }
end
