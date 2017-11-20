class UsersController < Devise::RegistrationsController
  attr_reader :user, :users

  load_and_authorize_resource

  def index
    @users = User.paginate page: params[:page]
  end

  def new
  end

  def create
    if user.save
      flash[:info] = t "create_check_email"
      redirect_to root_path
    else
      flash[:danger] = t "create_fail"
      render :new
    end
  end

  def show; end

  def edit; end

  def update
    if user.update_attributes user_params
      flash[:success] = t "update_succ"
      redirect_to user
    else
      flash[:danger] = t "update_fail"
      render :edit
    end
  end

  def destroy
    user.destroy
    flash[:success] = t "destroy_succ"
    redirect_to users_path
  end

  private

  def user_params
    params.require(:user).permit User::ATTRIBUTE_PARAMS
  end
end
