class ArticleSearchController < ApplicationController
  def index
  end

  def search
    user = User.find_by(uuid: cookies[:user_uuid])
    query = params[:query]
    search = user.searches.build(query: query)
    if search.save
      @articles = Article.search_with_text(query)
      render json: { articles: @articles }, status: :ok
    else
      render json: { errors: searh.errors.full_messages}, status: :not_acceptable
    end
  end
end
