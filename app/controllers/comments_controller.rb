class CommentsController < ApplicationController
    before_action :logged_in_user, only: [:create, :destroy]
    before_action :set_comment, only: [:show, :edit, :update, :destroy]
    respond_to :html, :js
    
  def new
    @comment = Comment.new
  end
  
  #def index
  #  @comments = Comment.paginate(page: params[:page], :per_page => 5).order('created_at DESC')
    
  #end

  def create
    @comment = current_user.comments.build(content: params[:comment][:content], user_id: params[:user_id], post_id: params[:post_id])
    @post = Post.find(params[:post_id])
    if @comment.save
      @comments = @post.comments.paginate(page: params[:page], :per_page => 10)
      respond_to do |format|
        format.js
      end
    else
      redirect_to root_url
    end
  end
  
  def destroy
    if current_user.admin?
      

      respond_to do |format|
        format.js
        
      end
      @comment.destroy
    end
  end
  
  def edit
    if current_user.admin?
      @content = @comment.content

      respond_to do |format|
        format.js
      end
    end
  end
  
  def update
    if current_user.admin?
      @comment.update_attributes(update_comment_params)
       respond_to do |format|
        format.js
      end
    end
  end

  private
  
    def set_comment
      @comment = Comment.find(params[:id])
    end

    def comment_params
      params.require(:comment).permit(:id, :content, :post_id).deep_merge(user_id: current_user.id)
    end
    
    def update_comment_params
      params.require(:comment).permit(:id, :content)
    end
    
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Proszę się zalogować"
        redirect_to login_url
      end
    end
end
