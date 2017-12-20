class Admin::UsersController < Admin::AdminController
  before_action :load_user, except: %i(new index)

  def index
    @users = User.user_attributes_select.order_by_created_at
      .page(params[:page]).per Settings.per_page
  end

  def edit; end

  def update
    if @user.update_attributes user_params
      flash[:success] = t "update_success"
      redirect_to request.referrer
    else
      flash[:danger] = t "update_failed"
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t "deleted"
    else
      flash[:danger] = t "delete_failed"
    end
    redirect_to request.referrer
  end

  private

  def user_params
    params.require(:user).permit :role
  end

  def load_user
    @user = User.find_by id: params[:id]

    return if @user
    flash[:danger] = t "not_found"
    redirect_to root_path
  end
end
