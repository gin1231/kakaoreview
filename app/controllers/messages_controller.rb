#encoding: utf-8
class MessagesController < ApplicationController

  before_filter :init_chat

  private
  def init_chat
    @chat = Chat.find(params[:chat_id])
  end

  public
  #async action
  def create
    @message = Message.new(params[:message])

    time = Time.now
    @message.message_date = time.strftime("%Y년 %m월 %d일")

    if time.hour > 12
      prefix = "오후"
    else
      prefix = "오전"
    end
    @message.message_time = prefix + " " + time.strftime("%l:%m")
  
    @chat.messages << @message

    if @message.save
      @result = {:status => true}
    else
      @result = {:status => false, :message => '저장 과정에서 오류가 발생했습니다.'}
    end 
  end

  #async action
  def update

  end
  
  #async action
  def destroy

  end

end
