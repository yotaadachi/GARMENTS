require 'rails_helper'

RSpec.describe Favorite, type: :model do
  before do
    @user = create(:user)
    @garment = create(:garment)
    @favorite = FactoryBot.build(:favorite)
  end

  describe "アソシエーションの検証" do
    it "お気に入り:ユーザー = N:1の関係となっている" do
      expect(Favorite.reflect_on_association(:user).macro).to eq :belongs_to
    end

    it "お気に入り:投稿 = N:1の関係となっている" do
      expect(Favorite.reflect_on_association(:garment).macro).to eq :belongs_to
    end
  end
end
