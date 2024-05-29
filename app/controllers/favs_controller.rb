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
      redirect_to favs_path, success: t('.success')
    else
      flash.now[:danger] = t('.fail')
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
    redirect_to favs_path, success: t('.success')
  end

  def update
    @fav = Fav.find(params[:id])
    if @fav.update(fav_params)
      redirect_to fav_path(@fav), success: t('.success')
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
