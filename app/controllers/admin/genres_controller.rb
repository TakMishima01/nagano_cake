class Admin::GenresController < ApplicationController
  before_action :authenticate_admin!, except: [:admin_session_path]

  def index
    @genres = Genre.all
    @genre = Genre.new
  end

  def create
    index
    genre = Genre.new(genre_params)
    if genre.save
      redirect_to '/admin/genres', notice: "登録が完了しました"
    else
      flash.now[:error] = "ジャンル名を入力してください"
      render :index
    end
  end

  def edit
    @genre = Genre.find(params[:id])
  end

  def update
    @genre = Genre.find(params[:id])
    if @genre.update(genre_params)
      redirect_to '/admin/genres', notice: "変更が完了しました"
    else
      flash.now[:error] = "ジャンル名を入力してください"
      render :edit
    end
  end

 private

  def genre_params
    params.require(:genre).permit(:name)
  end


end
