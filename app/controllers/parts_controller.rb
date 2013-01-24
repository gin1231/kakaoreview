class PartsController < ApplicationController
  layout :choose_layout

  before_filter :init_chat

  private
  def choose_layout
    if ['index'].include? action_name
      'part'
    else
      'frame'
    end
  end

  def init_chat
    @chat = Chat.find(params[:chat_id])
  end

  public
  def index
    @messages = @chat.messages.where(:_id.gte => params[:start], :_id.lte => params[:end])
  end

  def new
    @chats = current_user.chats
    @messages = @chat.messages.where(:_id.gte => params[:start], :_id.lte => params[:end])

    @quote = Quote.new
  end

  def create
    #create image with 'index' action
    url = chat_parts_path(:chat_id => @chat, :start => params[:start], :end => params[:end])
    file_path = Dir.pwd + "/public/system/" + @chat.id + "_" + rand(100..20000).to_s + ".png"
    full_url = "#{root_url}#{url}"
 
    if Rails.env.development?
      res = `xvfb-run --server-args="-screen 0, 360x240x24" cutycapt --url='http://m.naver.com' --out='#{file_path}' --max-wait=5000`
      file = File.open(file_path)
    else
      res = `xvfb-run --server-args="-screen 0, 360x240x24" cutycapt --url='http://choco.wafflestudio.net:2226' --out='#{file_path}' --max-wait=5000`
      file = File.open(file_path)
    end
        
    @quote = Quote.new(params[:quote])
    @quote.user = current_user
    @quote.chat = @chat
    @quote.img = file

    if @quote.save
      redirect_to quote_path(@quote)
    else
      render :action => 'new'
    end
  end

end
