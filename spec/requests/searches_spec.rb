require 'rails_helper'

RSpec.describe "Searches", type: :request do
  before(:example) do
    @user = AdminUser.create!(email: 'test@example.com', password: '123456')
  end

  describe 'GET /searches when' do
    it 'returns http success' do
      get '/searches'
      expect(response).to have_http_status(:found)
    end
  end

  describe 'GET /top-searches' do
    it 'returns http success' do
      get '/top-searches'
      expect(response).to have_http_status(:found)
    end
  end

  describe 'GET /searches when admin' do
    it 'returns http success' do
      sign_in @user
      get '/searches'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /top-searches when admin' do
    it 'returns http success' do
      sign_in @user
      get '/top-searches'
      expect(response).to have_http_status(:success)
    end
  end
end
