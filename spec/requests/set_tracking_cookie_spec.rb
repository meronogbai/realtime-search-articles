require 'rails_helper'

RSpec.describe "SetTrackingCookies", type: :request do
  describe 'when a user visits the website for the first time' do
    it 'sets tracking cookie' do
      expect(cookies[:user_uuid]).to be nil
      get '/'
      expect(cookies[:user_uuid]).not_to be nil
    end
  
    it 'creates user in the db and sets uuid equal to user_uuid cookie' do
      expect(User.count).to eq 0
      get '/'
      expect(User.first.uuid).to eq cookies[:user_uuid]
    end
  end
end
