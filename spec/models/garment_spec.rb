require 'rails_helper'

RSpec.describe Garment, type: :model do
  before do
    @user = create(:user)
    @garment = FactoryBot.build(:garment)
  end

  describe "アソシエーションの検証" do
    it "投稿:ユーザー = N:1の関係となっている" do
      expect(Garment.reflect_on_association(:user).macro).to eq :belongs_to
    end

    it "投稿:コメント = 1:Nの関係となっている" do
      expect(Garment.reflect_on_association(:comments).macro).to eq :has_many
    end
  end

  it "有効なファクトリを持つこと" do
    @garment.user_id = @user.id
    expect(@garment).to be_valid
  end

  it "タイトル、本文、ジャンル、写真、評価、タグがある場合、有効である" do
    garment = Garment.new(
      user_id: @user.id,
      title: "testtitle",
      body: "testbody",
      type: 1,
      image: Rack::Test::UploadedFile.new(File.join(Rails.root, 'app/assets/images/test.jpeg')),
      rate: 5,
      tag_list: "tag_list"
    )
    expect(garment).to be_valid
  end

  describe "存在の検証" do
    it "タイトルがない場合、無効である" do
      @garment.title = nil
      @garment.valid?
      expect(@garment.errors[:title]).to include("が入力されていません")
    end

    it "本文がない場合、無効である" do
      @garment.body = nil
      @garment.valid?
      expect(@garment.errors[:body]).to include("が入力されていません")
    end

    it "ジャンルがない場合、無効である" do
      @garment.type = nil
      @garment.valid?
      expect(@garment.errors[:type]).to include("が入力されていません")
    end

    it "写真がない場合、無効である" do
      @garment.image = nil
      @garment.valid?
      expect(@garment.errors[:image]).to include("が入力されていません")
    end

    it "評価がない場合、無効である" do
      @garment.rate = nil
      @garment.valid?
      expect(@garment.errors[:rate]).to include("が入力されていません")
    end

    it "タグがない場合、無効である" do
      @garment.tag_list = nil
      @garment.valid?
      expect(@garment.errors[:tag_list]).to include("が入力されていません")
    end
  end

  describe "文字数の検証" do
    it "本文が200字以内の場合、有効である" do
      @garment.user_id = @user.id
      @garment.body = "a" * 200
      expect(@garment).to be_valid
    end

    it "本文が200字以上の場合、無効である" do
      @garment.body = "a" * 201
      @garment.valid?
      expect(@garment.errors).to be_added(:body, :too_long, count: 200)
    end
  end
end
