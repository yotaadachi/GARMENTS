require 'rails_helper'

RSpec.describe Comment, type: :model do
  before do
    @user = create(:user)
    @garment = create(:garment)
    @comment = FactoryBot.build(:comment)
  end

  describe "アソシエーションの検証" do
    it "コメント:ユーザー = N:1の関係となっている" do
      expect(Comment.reflect_on_association(:user).macro).to eq :belongs_to
    end

    it "コメント:投稿 = N:1の関係となっている" do
      expect(Comment.reflect_on_association(:garment).macro).to eq :belongs_to
    end
  end

  it "コメントが140字以内の場合、有効である" do
    comment = Comment.new(
      user_id: @user.id,
      garment_id: @garment.id,
      body: "commentbody"
    )
    expect(comment).to be_valid
  end

  it "コメントが無い場合、無効である" do
    @comment.body = nil
    @comment.valid?
    expect(@comment.errors[:body]).to include("が入力されていません")
  end

  it "コメントが140字以上の場合、無効である" do
    @comment.body = "a" * 141
    @comment.valid?
    expect(@comment.errors).to be_added(:body, :too_long, count: 140)
  end
end
