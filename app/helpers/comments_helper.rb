module CommentsHelper
  def load_reply comment
    replies = Comment.reply comment
  end

  def can_edit_comment? comment
    comment.user == current_user
  end
end
