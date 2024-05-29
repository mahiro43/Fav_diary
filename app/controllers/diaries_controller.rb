class DiariesController < ApplicationController
  before_action :set_diary, only: [:show, :edit, :update, :destroy, :delete_image]
  before_action :set_fav
  before_action :set_diaries, only: [:index, :calendar]
  def index
    if params[:fav_id]
      @fav = Fav.find_by(id: params[:fav_id])
      @diaries = @fav.present? ? @fav.diaries.order(date: :desc) : Diary.none
      @fav_name = @fav&.name
    else
      @diaries = Doary.order(date: :desc)
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
      @diary.resize_images
      redirect_to fav_diaries_path(fav_id: @diary.fav_id), success: t('.success')
    else
      flash.now[:danger] = t('.fail')
<<<<<<< HEAD
      render :new, status: :unprocessable_entity
=======
      render :new
>>>>>>> 4b4bf67 (マップ、複数画像)
    end
  end

  def edit
    @fav = Fav.find(params[:fav_id])
    @diary = @fav.diaries.find(params[:id])
  end

  def update
    # 新しい画像がある場合のみ添付
    if diary_params[:images]
      @diary.images.attach(diary_params[:images])
    end
  
    # imagesパラメータを除外して日記のその他の属性を更新
    if @diary.update(diary_params.except(:images))
      @diary.resize_images if diary_params[:images]
      redirect_to fav_diaries_path(@diary.fav), success: t('.success')
    else
      flash.now[:danger] = t('.fail')
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @diary.destroy
    redirect_to fav_diaries_path(@fav), success: t('.success')
  end

  def show
  end
  
  def delete_image
    image = @diary.images.find(params[:image_id])
    image.purge if image.present?
    redirect_back(fallback_location: edit_fav_diary_path(@fav, @diary), notice: '画像が削除されました。')
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
    params.require(:diary).permit(:fav_id, :date, :content, :address, :latitude, :longitude, images: [])
  end
end
