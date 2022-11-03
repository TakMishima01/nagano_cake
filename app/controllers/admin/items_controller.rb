class Admin::ItemsController < ApplicationController

  def index
  end

  def new
    @item = Item.new
    @genre = Genre.all
  end

  def create
  end

  def show
  end

  def edit
  end

  def update
  end

end
