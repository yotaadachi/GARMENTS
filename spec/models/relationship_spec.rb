require 'rails_helper'

RSpec.describe Relationship, type: :model do

	before do
		@user = create(:user)
	end

	describe "アソシエーションの検証" do

		it "relationship:ユーザー = N:1の関係となっている" do
			expect(Relationship.reflect_on_association(:user).macro).to eq :belongs_to
		end

	end

	describe "登録の検証" do

		it "user_id, follow_idの全てが存在すれば登録できる" do
	    relationship = build(:relationship)
	    expect(relationship).to be_valid
	  end

	  it "user_idが存在しない場合は登録できない" do
	    relationship = build(:relationship, user_id: nil)
	    relationship.valid?
	    expect(relationship.errors[:user]).to include("は必須項目です")
	  end

	  it "follow_idが存在しない場合は登録できない" do
	    relationship = build(:relationship, follow_id: nil)
	    relationship.valid?
	    expect(relationship.errors[:follow]).to include("は必須項目です")
	  end

	  it "user_id, follow_idの組み合わせは一意でなければならない" do
	    other = create(:user, email: "a@a.com")
	    create(:relationship, user: @user, follow: other)
	    relationship2 = build(:relationship, user: @user, follow: other)
	    relationship2.valid?
	    expect(relationship2.errors[:follow_id]).to include("は既に登録済みです")
	 	end

 	end

end
