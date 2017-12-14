module CommentsHelper
  def load_reply comment
    replies = Comment.reply comment
  end
end
