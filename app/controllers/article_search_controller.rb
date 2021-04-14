class ArticleSearchController < ApplicationController
  def index
  end

  def search
    user = User.find_by(uuid: cookies[:user_uuid])
    query = params[:query]
    search = user.searches.create(query: query)
    @articles = Article.search_with_text(query)
    render json: { articles: @articles }
  end
end
