class FavsController < ApplicationController
  def index
    @favs = Fav.all
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

  private

  def set_fav
    @fav = Fav.find(params[:id])
  end

  def fav_params
    params.require(:fav).permit(:name, :nickname, :birthday, :color, :comments, :image)
  end
end
