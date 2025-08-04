class UsersController < ApplicationController
  before_action :set_user, only: [ :show, :edit, :update, :destroy ]
  before_action :require_user, only: [:edit, :update, :destroy]
  before_action :require_same_user, only: [:edit, :update, :destroy]
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to users_path, notice: "Welcome to the My Blog, #{@user.name} was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @articles = @user.articles
    @articles = @user.articles.paginate(page: params[:page], per_page: 5)
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: "User profile updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
    redirect_to users_path, notice: "User profile and all associated deleted successfully."
  end
  def index
    @users = User.paginate(page: params[:page], per_page: 3)
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
  def set_user
    @user = User.find(params[:id])
  end

  def require_same_user
    if current_user != @user && !current_user.admin?
      flash[:alert] = "You can only edit or delete your own profile."
      redirect_to @user
    end
  end
end
