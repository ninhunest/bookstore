class Admin::CommentController < Admin::AdminController
  def index
    @comments = Comment.attributes_select.order_by_created_at
      .page(params[:page]).per Settings.per_page
  end

  def destroy
    if @comment.delete
      respond_to do |format|
        format.html do
          flash[:success] = t "delete_success"
          redirect_to request.referrer
        end
        format.js
      end
    else
      flash[:danger] = t "failed_delete"
      redirect_to request.referrer
    end
  end
end
