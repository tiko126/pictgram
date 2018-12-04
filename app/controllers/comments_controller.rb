class CommentsController < ApplicationController
  def new
    comment = Comment.new
  end

  def create
    @comment = current_user.comments.new(
      comment_params
      #text: params[:comments][:text],
      #topic_id: params[:comments][:topic_id])
    )
    
    if @comment.save
      redirect_to topics_path, success: 'コメントを保存しました'
    else
      flash.now[:danger] = 'コメントの保存に失敗しました'
      render :new
    end
  end

  private
  def comment_params
    params.require(:comments).permit(:text, :topic_id)
  end
end
