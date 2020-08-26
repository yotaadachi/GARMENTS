class UsersController < ApplicationController
  def show
  	@user = User.find(params[:id])
  end

  def myindex
    @user = User.find(params[:id])
    if params[:q].present?
    # ソートをした時の処理
      @sorts = @user.garments.ransack(sort_params)
      @garments = @sorts.result.page(params[:page])
    else
    # ソートを行う前の処理(default)
      params[:q] = { sorts: 'id desc' }
      @sorts = @user.garments.ransack()
      @garments = @sorts.result.page(params[:page])
    end
  end

  def edit
    @user = User.find(params[:id])
    if @user == current_user
       render :edit
    else
       redirect_to user_path(current_user)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
       flash[:notice] = 'ユーザ情報が更新されました'
       redirect_to user_path(@user.id)
    else
       render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

  def sort_params
    params.require(:q).permit(:sorts)
  end
end
