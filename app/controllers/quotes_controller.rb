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
  end

  def edit
  end

  def update
  end

  def destroy
  end

  #async action
  def rate
    @quote = Quote.find(params[:id])
    
    if @quote.rate.where(:user_id => current_user.id).length > 0
      @result = {:status => false, :message => '이미 평가하셨습니다.'}
      return
    end

    @rate = Rate.new(:like => params[:like])
    @rate.quote = @quote
    @rate.user = current_user

    if @rate.save
      @result = {:status => true}
    else
      @result = {:status => false, :message => '저장 과정에서 오류가 발생했습니다.'}
    end
  end
end
