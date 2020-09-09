require 'rails_helper'

RSpec.describe User, type: :model do

	it "名前、メールアドレス、パスワードがある場合、有効である" do

		user = FactoryBot.build(:user)
		expect(user).to be_valid

	end

	it "名前がない場合、無効である" do

		user = FactoryBot.build(:user, name: nil)
		user.valid?
		expect(user.errors[:name]).to include("が入力されていません")

	end

	it "メールアドレスがない場合、無効である" do

		user = FactoryBot.build(:user, email: nil)
		user.valid?
		expect(user.errors[:email]).to include("が入力されていません")

	end

	it "パスワードがない場合、無効である" do

		user = FactoryBot.build(:user, password: nil)
		user.valid?
		expect(user.errors[:password]).to include("が入力されていません")

	end

end
