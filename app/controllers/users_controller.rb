class UsersController < ApplicationController
  before_action :logged_in_user, only: [:destroy, :index, :edit, :update]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy

  
  def new
    @user = User.new
  end
  
  def index
    @users = User.where(activated: true).paginate(page: params[:page], :per_page => 10)
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
    @user = User.new(user_params) 
    if @user.save
      @user.send_activation_email
      flash[:info] = "Na podany adres email został wysłany link aktywacyjny."
      redirect_to root_url
    else
      render 'new'
    end
  end
  
  def edit
    @edit = true
  end
  
  def update
    if @user.authenticated?(:password, params[:user][:password])
      params[:user].delete(:password)
      if @user.update_attributes(user_params)
        flash[:success] = "Profil zaktualizowany"
        redirect_to @user
      else
        @edit = true
        render 'edit'
      end
    else
      @edit = true
      flash[:danger] = "Nieprawidłowe hasło"
      render 'edit'
    end
  end
  
  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation, :avatar)
    end
    
    
    
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
    
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
    
end
