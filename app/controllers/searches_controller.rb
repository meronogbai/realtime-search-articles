class SearchesController < ApplicationController
  before_action :authenticate_admin_user!

  def index
    @searches = Search.select(:query).distinct
  end
end
