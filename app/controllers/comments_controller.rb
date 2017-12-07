class CommentsController < ApplicationController
  before_action :comment_params, only: %i(create)
  before_action :load_comment, only: :destroy
  before_action :load_book, only: :destroy

  def create
    @book = Book.find_by id: params[:comment][:book_id]
    @comment = @book.comments.new comment_params

    if @comment.save!
      @comments = Comment.load_comment(@book).except_reply.select_fields
        .order_by_created_at.limit Settings.comments.limit
      respond_to do |format|
        format.js
      end
    else
      flash[:danger] = t "create_comment_failed"
      redirect_to @book
    end
  end

  def destroy
    if @comment.destroy!
      @comments = Comment.load_comment(@book).except_reply.select_fields
        .order_by_created_at.limit Settings.comments.limit

      respond_to do |format|
        format.js
      end
    else
      flash[:danger] = t "comment_delete_failed"
      redirect_to @book
    end
  end

  private

  def load_comment
    @comment = Comment.find_by id: params[:id]
  end

  def load_book
    @book = @comment.book
  end

  def comment_params
    params.require(:comment).permit :book_id, :content, :user_id, :parent_id
  end
end
