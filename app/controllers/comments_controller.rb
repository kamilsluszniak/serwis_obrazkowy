class CommentsController < ApplicationController
    before_action :logged_in_user, only: [:create, :destroy]
    respond_to :html, :js
    
  def new
    @comment = Comment.new
  end

  def create
    @comment = current_user.comments.build(content: params[:comment][:content], user_id: params[:user_id], post_id: params[:post_id])
    @post = Post.find(params[:post_id])
    if @comment.save
      @comments = Comment.where("post_id = ?", params[:post_id]).paginate(page: params[:page], :per_page => 5)
      #flash[:success] = "Komentarz dodany!"
      respond_to do |format|
        format.js
      end
    else
      redirect_to root_url
    end
  end
  
  def destroy
  end

  private

    def comment_params
      params.require(:comment).permit(:content, :post_id).deep_merge(user_id: current_user.id)
    end
    
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Proszę się zalogować"
        redirect_to login_url
      end
    end
end
