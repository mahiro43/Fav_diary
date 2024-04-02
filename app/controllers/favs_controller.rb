class FavsController < ApplicationController
  before_action :set_fav, only: [:show, :edit, :update, :destroy]
  def index
    #@favs = Fav.all
    @favs = current_user.favs
  end
    
  def new
    @fav = Fav.new
  end
    
  def create
    @fav = current_user.favs.build(fav_params)
    if @fav.save
      redirect_to favs_path, notice: 'Fav was successfully created.'
    else
      logger.debug @fav.errors.full_messages
      render :new
    end
  end

  def show
    @fav = Fav.find(params[:id])
  end
  
  def edit
  end

  def destroy
    @fav = Fav.find(params[:id])
    @fav.destroy
    redirect_to favs_path, notice: '削除されました。'
  end

  def update
    @fav = Fav.find(params[:id])
    if @fav.update(fav_params)
      redirect_to fav_path(@fav), notice: '推しのプロフィールが更新されました。'
    else
      render :edit
    end
  end

  private
    
  def set_fav
    @fav = Fav.find(params[:id])
  end
    
  def fav_params
    params.require(:fav).permit(:name, :nickname, :birthday, :color, :comments, :image)
  end
end
