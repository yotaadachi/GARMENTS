class SearchesController < ApplicationController
  def index
  	@range = params[:range]
  	word = params[:word]

  	if @range == '1'
  	  @users = User.search(word)
  	else
  	  @garments = Garment.search(word)
  	end

  end

end
