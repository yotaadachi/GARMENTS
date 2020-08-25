class FavoritesController < ApplicationController

  def index
  	@user = User.find(params[:user_id])
    # @user_favorites = Favorite.where(user_id: @user.id)
  end

  def create
	  @garment = Garment.find(params[:garment_id])
	  favorite = current_user.favorites.new(garment_id: @garment.id)
	  favorite.save
  end

  def destroy
  	@garment = Garment.find(params[:garment_id])
  	favorite = current_user.favorites.find_by(garment_id: @garment.id)
  	favorite.destroy
  end


end
