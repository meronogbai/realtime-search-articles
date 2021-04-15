class ArticlesController < ApplicationController
  def index
    @articles = Article.paginate(page: params[:page], per_page: 10)
  end

  def show
    @article = Article.find_by(id: params[:id])
    redirect_to root_path, alert: "Article doesn't exist." unless @article
  end
end
