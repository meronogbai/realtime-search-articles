class ArticleSearchController < ApplicationController
  def index
  end

  def search
    query = params[:query]
    User.find_by(uuid: cookies[:user_uuid]).searches.build(query: query)
    @articles = Article.search_with_text(query)
  end
end
