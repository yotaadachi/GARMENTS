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
      # ソートをした時の処理

    else

      # ソートを行う前の処理(default)
      params[:q] = { sorts: 'id desc' }
      @sorts = @user.garments.ransack()
      @garments = @sorts.result.page(params[:page])
      # ソートを行う前の処理(default)

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
       flash[:notice] = "ユーザ情報が更新されました"
       redirect_to user_path(@user.id)
    else
       flash[:alert] = "ユーザ情報を更新できませんでした"
       render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def sort_params
    params.require(:q).permit(:sorts)
  end

end