class GarmentsController < ApplicationController
  def index
    garments = Garment.all
  end

  def show
  end

  def new
    @garment = Garment.new
  end

  def create
    garment = Garment.new(garment_params)
    garment.user_id = current_user.id
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
  params.require(:garment).permit(:title, :body)
  end

end
