class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  # GET /posts
  # GET /posts.json
  def index
    if params[:random]
      @posts =  Post.order('random()').page(params[:page]).per_page(10)
    else
      @posts = Post.paginate(page: params[:page], :per_page => 10).order('created_at DESC')
    end
    
    #= Post.paginate(page: params[:page], :per_page => 10, :order => 'RANDOM()')
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    
  end

  # GET /posts/new
  def new
    @post = Post.new
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
    
    if (@post.user_id == @current_user.id) && @post.save 
      flash[:success] = "Post dodany. Możesz go edytować przed upływem 5 minut "
      redirect_to @post
    else
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
    render js: "$('.span-rating').html('Głosy: #{@post.rating} ')"
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
      params.require(:post).permit(:title, :content, :user_id, :attachment, :random)
    end
end
