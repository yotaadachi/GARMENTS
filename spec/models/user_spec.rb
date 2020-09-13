require 'rails_helper'

RSpec.describe User, type: :model do

	before do
		@user = FactoryBot.build(:user)
	end

	describe "アソシエーションの検証" do

		it "ユーザー:投稿 = 1:Nの関係となっている" do
			expect(User.reflect_on_association(:garments).macro).to eq :has_many
		end

		it "ユーザー:コメント = 1:Nの関係となっている" do
			expect(User.reflect_on_association(:comments).macro).to eq :has_many
		end

    it "ユーザー:お気に入り = 1:Nの関係となっている" do
      expect(User.reflect_on_association(:favorites).macro).to eq :has_many
    end

    it "ユーザー:relationship = 1:Nの関係となっている" do
      expect(User.reflect_on_association(:relationships).macro).to eq :has_many
    end

	end

	it "有効なファクトリを持つこと" do
    expect(FactoryBot.build(:user)).to be_valid
  end

  it "名前、メールアドレス、パスワードがある場合、有効である" do
		user = User.new(
		name: "testuser",
		email: "test@mail.com",
		password: "password"
		)
		expect(user).to be_valid
	end

	describe "存在の検証" do

		it "名前がない場合、無効である" do
			@user.name = nil
			@user.valid?
			expect(@user.errors[:name]).to include("が入力されていません")
		end

		it "メールアドレスがない場合、無効である" do
			@user.email = nil
			@user.valid?
			expect(@user.errors[:email]).to include("が入力されていません")
		end

		it "パスワードがない場合、無効である" do
			@user.password = nil
			@user.valid?
			expect(@user.errors[:password]).to include("が入力されていません")
		end

  end

  describe "文字数の検証" do

  	it "名前が30文字以内の場合、有効である" do
  		@user.name = "a" * 30
  		expect(@user).to be_valid
  	end

  	it "名前が30文字以上の場合、無効である" do
  		@user.name = "a" * 31
  		@user.valid?
  		expect(@user.errors).to be_added(:name, :too_long, count: 30)
  	end

		it "自己紹介文が200字以内の場合、有効である" do
			@user.introduction = "a" * 200
			expect(@user).to be_valid
		end

		it "自己紹介文が200字以上の場合、無効である" do
			@user.introduction = "a" * 201
			@user.valid?
			expect(@user.errors).to be_added(:introduction, :too_long, count: 200)
		end

	end

end
