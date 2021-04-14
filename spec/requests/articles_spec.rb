require 'rails_helper'

RSpec.describe "Articles", type: :request do
  describe 'GET /articles' do
    it 'returns http success' do
      get '/articles'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /article/:id' do
    it 'returns http success' do
      article = Article.create!(title: 'test', body: 'test')
      get "/articles/#{article.id}"
      expect(response).to have_http_status(:success)
    end
  end
end
