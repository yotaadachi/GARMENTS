class GarmentsController < ApplicationController
  before_action :authenticate_user!
  def index
    @garments = Garment.all.page(params[:page]).reverse_order
  end

  def show
    @garment = Garment.find(params[:id])
    @comment = Comment.new
  end

  def new
    @garment = Garment.new
  end

  def create
    garment = Garment.new(garment_params)
     if garment.save
        flash[:notice] = '投稿しました'
        redirect_to garment_path(garment.id)
     else
        @garments = Garment.all.page(params[:page]).reverse_order
        render :index
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
       flash[:notice] = '投稿を更新しました'
       redirect_to garment_path(@garment.id)
    else
       render :edit
    end
  end

  def destroy
    garment = Garment.find(params[:id])
    garment.destroy
    redirect_to garments_path
  end

  private

  def garment_params
    params.require(:garment).permit(:title, :body, :image, :rate, :type, :user_id, :tag_list)
  end

end
