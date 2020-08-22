class GarmentsController < ApplicationController
  before_action :authenticate_user!
  def index
    @garments = Garment.all
  end

  def show
    @garment = Garment.find(params[:id])
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
        @garments = Garment.all
        render :index
     end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def garment_params
    params.require(:garment).permit(:title, :body, :image, :rate, :type, :user_id, :tag_list)
  end

end
