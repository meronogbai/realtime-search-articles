require 'rails_helper'

RSpec.describe "ArticleSearches", type: :request do
  describe 'GET /' do
    it 'returns http success' do
      get '/'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /search' do
    it 'returns http success' do
      get '/search?query=test'
      expect(response).to have_http_status(:success)
    end
  end
end
