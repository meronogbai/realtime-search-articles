require 'rails_helper'

RSpec.describe Search, type: :model do
  before(:example) do
    uuid = SecureRandom.uuid
    @user = User.create(uuid: uuid)
  end

  it 'downcases queries' do
    search = @user.searches.create(query: 'HELLO')
    expect(search.query).to eq 'hello'
  end

  it 'deletes previous search if new query starts with previous query' do
    @user.searches.create([
      { query: 'What' },
      { query: 'What is a' },
      { query: 'What is a good car?' },
    ])
    expect(@user.searches.count).to eq 1
    expect(@user.searches.last.query).to eq 'what is a good car?'
  end

  it 'deletes previous search if new query starts with previous query and ignores whitespace' do
    @user.searches.create([
      { query: 'How is' },
      { query: 'Howis emil hajric' },
      { query: 'How is emil hajric doing?' },
    ])
    expect(@user.searches.count).to eq 1
    expect(@user.searches.last.query).to eq 'how is emil hajric doing?'
  end

  it 'deletes previous search if new query starts with previous query and case whitespace' do
    @user.searches.create([
      { query: 'hello' },
      { query: 'Hello world' },
      { query: 'Hello world how are you?' },
    ])
    expect(@user.searches.count).to eq 1
    expect(@user.searches.last.query).to eq 'hello world how are you?'
  end

  it "invalidate search if query is a subset of previous query" do
    first_search = @user.searches.create(query: 'Hello world')
    second_search = @user.searches.create(query: 'Hello worl')
    expect(second_search.valid?).to be false
  end
end
