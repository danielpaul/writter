require 'spec_helper'

describe "GET '/'" do
  it 'shows the articles' do
    visit '/'
    expect(page.body).to include("Articles")
  end
  it 'shows new article button' do
    visit '/'
    expect(page.body).to include("New Article")
  end
end
