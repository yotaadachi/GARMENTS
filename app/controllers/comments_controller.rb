class CommentsController < ApplicationController
  def create
    @garment = Garment.find(params[:garment_id])
    comment = @garment.comments.new(comment_params)
    comment.user_id = current_user.id
    comment_garment = comment.garment
    if comment.save
      # 通知機能
      comment_garment.create_notification_comment!(current_user, comment.id)
    end
    @comment = Comment.new
  end

  def destroy
    @comment = Comment.find_by(id: params[:id], garment_id: params[:garment_id])
    @comment.destroy
    @garment = @comment.garment
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
