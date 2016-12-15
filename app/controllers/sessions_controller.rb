class SessionsController < ApplicationController


  def new
  end

  def create
    @email = params[:session][:email] unless params[:session].nil?
    if @email.present? 
      @email.downcase!
      @user = User.find_by(email: @email)
      if @user && @user.authenticate(params[:session][:password])
        if @user.activated?
          log_in @user
          params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
          redirect_back_or @user
        else
          message  = "Konto nie zostało aktywowane. "
          message += "Sprawdź pocztę - powinien na niej być link aktywacyjny."
          flash[:warning] = message
          redirect_to root_url
        end
      else
        flash.now[:danger] = 'Niepoprawne dane'
        render 'new'
      end
    elsif (@fb_user = FacebookUser.from_omniauth(request.env["omniauth.auth"]))
      @user = FacebookUser.find_by(@fb_user.uid).user
      unless @user
        @pw = SecureRandom.urlsafe_base64
        @new_user = User.new(name: @fb_user.name, email: @fb_user.email, password: @pw, password_confirmation: @pw, activated: true, activated_at: Time.zone.now)
        @new_user.facebook_user = @fb_user
        #@new_user.avatar = User.koala_fetch_fb_profile_image(@fb_user.oauth_token)
        
        if @new_user.avatar
          @new_user.save!
        else
          @fb_user.destroy
        end
        puts @new_user.errors.full_messages
        session[:user_id] = @new_user.id
        redirect_to root_url
      else
        session[:user_id] = @user.id
        redirect_to root_url
      end
    else
      flash.now[:danger] = 'Niepoprawne dane'
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
  
end