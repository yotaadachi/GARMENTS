class UsersController < ApplicationController
  def show
  	@user = User.find(params[:id])
  end

  def edit
  end

  def update
  end

  private
  def user_params
    @_params.require(:user).permit(:name, :profile_image, :introduction)
  end
end
