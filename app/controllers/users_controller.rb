class UsersController < ApplicationController
  before_action :logged_in_user, only: [:destroy, :index, :edit, :update]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy

  
  def new
    @user = User.new
  end
  
  def index
    @users = User.paginate(page: params[:page], :per_page => 10)
  end

  def show
    @user = User.find(params[:id])
  end
  
  def destroy
    @deleted_user = User.find(params[:id]).destroy
    flash[:success] = "Użytkownik #{@deleted_user.name} usunięty"
    redirect_to users_url
  end
  
  def create
    @user = User.new(user_params)    # Not the final implementation!
    if @user.save
      log_in @user
      flash[:success] = "Witam!"
      redirect_to @user   #to samo co redirect_to user_url(@user)
    else
      render 'new'
    end
  end
  
  def edit
    
  end
  
  def update
    if @user.update_attributes(user_params)
      flash[:success] = "Profil zaktualizowany"
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end
    
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Proszę się zalogować"
        redirect_to login_url
      end
    end
    
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
    
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
    
end
