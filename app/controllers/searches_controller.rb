class SearchesController < ApplicationController
  before_action :authenticate_admin_user!

  def index
    @searches = Search.select(:query).distinct.paginate(page: params[:page], per_page: 10)
  end

  def top
    @top = Search.top_five
  end
end
