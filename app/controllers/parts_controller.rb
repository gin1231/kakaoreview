class PartsController < ApplicationController
  layout :choose_layout

  private
  def choose_layout
    if ['index'].include? action_name
      'part'
    else
      'frame'
    end
  end

  public
  def index
    @chat = Chat.find(params[:chat_id])
    @messages = @chat.messages.where(:_id.gte => params[:start], :_id.lte => params[:end])
  end

  def new
    @chats = current_user.chats #temp


    @chat = Chat.find(params[:chat_id])
    @messages = @chat.messages.where(:_id.gte => params[:start], :_id.lte => params[:end])

  end

  def create
    #TODO: create image with 'index' action
    #start = params[:start], end = params[:end]

  end

end
