#encoding: utf-8
class QuotesController < ApplicationController
  layout 'frame'

  def index
    sort = params[:sort]

    @quotes = Quote.all
  end

  def show
    @quote = Quote.find(params[:id])
    @comment = Comment.new
  end

  def new
  end

  def create
    ##FOR TEST
    @quote = Quote.new(:title => '이거', 'content' => '내용임')
    @quote.user = User.first
    @quote.chat = Chat.first
    ##FOR TEST

    if @quote.save
      redirect_to quote_path(@quote)
    else
      redirect_to quotes_path
    end

  end

  def edit
  end

  def update
  end

  def destroy
  end
end
