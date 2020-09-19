class FavoritesController < ApplicationController
  def index
    @user = User.find(params[:user_id])
  end

  def create
    @garment = Garment.find(params[:garment_id])
    favorite = current_user.favorites.new(garment_id: @garment.id)
    favorite.save
    # 通知機能
    @garment.create_notification_by(current_user)
    respond_to do |format|
      format.html { redirect_to request.referrer }
      format.js
    end
  end

  def destroy
    @garment = Garment.find(params[:garment_id])
    favorite = current_user.favorites.find_by(garment_id: @garment.id)
    favorite.destroy
  end
end
