class SearchesController < ApplicationController
  def index
    @range = params[:range]
    word = params[:word]

    if @range == '1'

      # ユーザー検索結果
      @users = User.search(word)
      # ユーザー検索結果

    else

      # garments検索結果
      @garments = Garment.search(word)
      # garments検索結果

    end
  end
end
