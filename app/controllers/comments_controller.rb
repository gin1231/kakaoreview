class CommentsController < ApplicationController

  def create
    @quote = Quote.find(params[:quote_id])
    @comment = Comment.new(params[:comment])
    @comment.user = current_user

    @comment.quote = @quote

    if @comment.save
      redirect_to quote_path(@quote)
    else
      redirect_to quote_path(@quote)
    end
  end
end
