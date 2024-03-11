class DiariesController < ApplicationController
  before_action :set_diary, only: [:show, :edit, :update, :destroy]
  before_action :set_fav
  def index
    if params[:fav_id]
      @fav = Fav.find_by(id: params[:fav_id])
      @diaries = @fav.present? ? @fav.diaries : Diary.none
      @fav_name = @fav&.name
    else
      @diaries = Doary.all
    end
  end
    
  def new
    @diary = Diary.new(fav_id: params[:fav_id])
  end
    
  def create
    @diary = Diary.new(diary_params)
    
    if @diary.save
      redirect_to fav_diaries_path(fav_id: @diary.fav_id), notice: '日記が正常に作成されました。'
    else
      render :new
    end
  end

  def edit
    @fav = Fav.find(params[:fav_id])
    @diary = @fav.diaries.find(params[:id])
  end

  def update
    if @diary.update(diary_params)
      redirect_to fav_diaries_path(@diary.fav), notice: '日記が更新されました。'
    else
      render :edit
    end
  end

  def destroy
    @diary.destroy
    redirect_to fav_diaries_path(@fav), notice: '日記が削除されました。'
  end

  def show
  end
        
  private

  def set_fav
    @fav = Fav.find(params[:fav_id])
  end

  def set_diary
    @diary = Diary.find(params[:id])
  end
        
  def diary_params
    params.require(:diary).permit(:fav_id, :date, :content)
  end
end
