require 'rails_helper'

RSpec.describe Relationship, type: :model do

	let(:user) { create(:user) }
	let(:other_user) { create(:user) }
	let(:user_relationship) { user.active_relationships.build(follow_id: other_user.id) }

	it "リレーションシップが有効かどうか" do
		expect(user_relationship).to be_valid
	end

	describe "フォロワーの検証" do

		it "フォローしたユーザーを返す" do
			expect(user_relationship.follower).to eq(user)
		end

	end

	describe "フォローの検証" do

		it "フォローしているユーザーを返す" do
			expect(user_relationship.follow).to eq(other_user)
		end

	end
end
