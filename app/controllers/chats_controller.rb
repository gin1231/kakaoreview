class ChatsController < ApplicationController
  layout 'frame'

  before_filter :set_chats, :only => [:index, :show, :new, :edit]

  private
  def set_chats
    if user_signed_in?
      @chats = current_user.chats
    else
      #redirect_to new_user_session_path
      @chats = User.first.chats
    end
  end


  public
  # GET /chats
  # GET /chats.json
  def index
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @chats }
    end
  end

  # GET /chats/1
  # GET /chats/1.json
  def show
    @chat = Chat.find(params[:id])
    @message = Message.new

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @chat }
    end
  end

  # GET /chats/new
  # GET /chats/new.json
  def new
    @chat = Chat.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @chat }
    end
  end

  # POST /chats
  # POST /chats.json
  def create
    @chat = Chat.create_chat(params[:chat], current_user)

    respond_to do |format|
      if @chat
        format.html { redirect_to @chat, notice: 'Chat was successfully created.' }
        format.json { render json: @chat, status: :created, location: @chat }
      else
        format.html { render action: "new" }
        format.json { render json: @chat.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /chats/1
  # PUT /chats/1.json
  def update
    @chat = Chat.find(params[:id])
    @chat.update_attributes(params[:chat])
  end

  # DELETE /chats/1
  # DELETE /chats/1.json
  def destroy
    @chat = Chat.find(params[:id])
    @chat.destroy

    respond_to do |format|
      format.html { redirect_to chats_url }
      format.json { head :no_content }
    end
  end


end
