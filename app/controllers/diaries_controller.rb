class DiariesController < ApplicationController
  before_action :set_diary, only: [:show, :edit, :update, :destroy]
  before_action :set_fav
  before_action :set_diaries, only: [:index, :calendar]
  def index
    if params[:fav_id]
      @fav = Fav.find_by(id: params[:fav_id])
      @diaries = @fav.present? ? @fav.diaries : Diary.none
      @fav_name = @fav&.name
    else
      @diaries = Doary.all
    end
  end

  def search
    @q = @fav.diaries.ransack(params[:q])
    @diaries = @q.result(distinct: true) if params[:q].present? && params[:q][:content_cont].present?
  end
  
  def autocomplete
    query = params[:term] || params[:q]  # クエリパラメータに応じて調整
    @diaries = @fav.diaries.where("content LIKE ?", "%#{query}%").limit(5)
    render json: @diaries.map { |diary| { id: diary.id, content: diary.content } }
  end

  def calendar
    @fav_name = @fav&.name
    @date = params[:start_date] ? params[:start_date].to_date : Date.today
    start_date = @date.beginning_of_month
    end_date = @date.end_of_month

    # その月の日記だけを取得するための範囲を設定
    @monthly_diaries = @diaries.where(date: start_date..end_date)

    # カレンダーを表示するための日付範囲
    @date_range = (start_date.beginning_of_week(:monday)..end_date.end_of_week(:monday)).to_a
  end

  def autocomplete
    query = params[:term] || params[:q]  # クエリパラメータに応じて調整
    @diaries = @fav.diaries.where("content LIKE ?", "%#{query}%").limit(5)
    render json: @diaries.map { |diary| { id: diary.id, content: diary.content } }
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

  def set_diaries
    @diaries = @fav ? @fav.diaries : Diary.all
  end
        
  def diary_params
    params.require(:diary).permit(:fav_id, :date, :content)
  end
end
