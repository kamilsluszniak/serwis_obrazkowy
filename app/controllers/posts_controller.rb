class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  respond_to :html, :js

  # GET /posts
  # GET /posts.json
  def index
    
    
    if params[:random]
      @posts =  Post.order('random()').page(params[:page]).per_page(10)
      get_yt_array_for @posts
    else
      @posts = Post.paginate(page: params[:page], :per_page => 10).order('created_at DESC')
      get_yt_array_for @posts
    end
  
    #= Post.paginate(page: params[:page], :per_page => 10, :order => 'RANDOM()')
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @comment = Comment.new
    @comments = Comment.where("post_id = ?", params[:id]).paginate(page: params[:page], :per_page => 5)
    
  end

  # GET /posts/new
  def new
    unless logged_in?
      flash[:danger] = "Musisz najpierw się zalogować."
      redirect_to login_path
    else
      @post = Post.new
    end
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @current_user = current_user
    @post = Post.new(post_params)
    @post.user_id = @current_user.id
    if (@post.attachment.present? ^ @post.video_link.present?)
      if (@post.user_id == @current_user.id) && @post.save 
        flash[:success] = "Post dodany. Możesz go edytować przed upływem 5 minut "
        redirect_to root_url
      else
        flash[:danger] = "Musisz najpierw się zalogować."
        redirect_to root_url
      end
    elsif (@post.attachment.present? && @post.video_link.present?)
      flash.now[:danger] = "Nie można jednocześnie dodać obrazka i filmu"
      render 'new'
    elsif !(@post.attachment.present? || @post.video_link.present?)
      flash.now[:danger] = "Musisz dodać obrazek lub film"
      render 'new'
    end
    
  end
  
  def rate
    @id = params[:id]
    @post = Post.find(@id)
    if params[:rate] && current_user
      @current_user_id = current_user.id
      if !(@post.users_voted.include? "i#{@current_user_id}")
        @post.users_voted += "i#{current_user.id.to_s}"
        @post.rating += 1
        @post.save
      else
        @message = "Można głosować tylko raz na każdy post!"
        respond_to do |format|
          format.js { render :file => "/posts/rate_modal_prompt.js.erb" }
        end
        return
      end
    end
    render js: "$('.rating').html('Głosy: #{@post.rating} ')"
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    if (@post.user == current_user) && ((@post.created_at > 5.minutes.ago) || current_user.admin?)
      @post.update_attributes(post_params)
      flash[:success] = "Post edytowany pomyślnie"
      redirect_to @post
    else
      flash[:danger] = "Nie można edytować postów po upływie 5 minut od ich utworzenia"
      redirect_to root_url
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    if (@post.user == current_user) && ((@post.created_at > 5.minutes.ago) || current_user.admin?)
      @post.destroy
      flash[:success] = "Post usunięty pomyślnie"
      redirect_to root_url
    else
      flash[:danger] = "Nie można usunąć postów po upływie 5 minut od ich utworzenia"
      redirect_to root_url
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :content, :user_id, :attachment, :random, :rate, :id, :video_link)
    end
    
    def get_yt_array_for(posts)
      @yt = posts.where("yt_uid is NOT NULL and yt_uid != ''")
      @ar = Array.new
      @yt.collect do |yt|
        @ar << yt.id
        @ar << yt.yt_uid
      end
    end
end
