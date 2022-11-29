class ApplicationController < ActionController::Base
  before_action :set_search

  def set_search
    @search = Item.ransack(params[:q])
    @search_items = @search.result
    @search_view = @search.result.page(params[:page]).per(8)
  end
end
