class GarmentsController < ApplicationController

  before_action :authenticate_user!

  def index
    if params[:q].present?

      # ソートをした時の処理
      @sorts = Garment.ransack(sort_params)
      @garments = @sorts.result.page(params[:page])
      # ソートをした時の処理

    else

      # ソートを行う前の処理(default)
      params[:q] = { sorts: 'id desc' }
      @sorts = Garment.ransack()
      @garments = @sorts.result.page(params[:page])
      # ソートを行う前の処理(default)

    end
  end

  def show
    @garment = Garment.find(params[:id])
    @comment = Comment.new
  end

  def new
    @garment = Garment.new
  end

  def create
    @garment = Garment.new(garment_params)
     if @garment.save
        flash[:notice] = "新規投稿しました"
        redirect_to garment_path(@garment.id)
     else
        render :new
     end
  end

  def edit
    @garment = Garment.find(params[:id])
    if @garment.user == current_user
       render :edit
    else
       redirect_to garments_path
    end
  end

  def update
    @garment = Garment.find(params[:id])
    if @garment.update(garment_params)
       flash[:notice] = "投稿内容を更新しました"
       redirect_to garment_path(@garment.id)
    else
       flash[:alert] = "エラーにより投稿内容を更新できません"
       render :edit
    end
  end

  def destroy
    garment = Garment.find(params[:id])
    garment.destroy
    flash[:notice] = "投稿を削除しました"
    redirect_to garments_path
  end

  private

  def garment_params
    params.require(:garment).permit(:user_id, :title, :body, :image, :type, :rate, :tag_list)
  end

  def sort_params
    params.require(:q).permit(:sorts)
  end

end