class ChatMailer < ActionMailer::Base
	def receive(message)
    #find user
    user = User.where(:username => message.to[0].split("@")[0]).first
    unless user
      return
    end

    #read files and create chat
    new_chat = nil
    new_atts = Array.new

    message.attachments.each do |att|
      file = StringIO.new(att.body.decoded)
      file.class.class_eval {attr_accessor :original_filename, :content_type}
      file.original_filename = att.filename
      file.content_type = att.mime_type

      ext = att.filename[-4..-1]
      if ext == ".txt"
        chat_params = {:title => message.subject, :chatfile => file, :chat_type => Chat::UPLOADED}
        new_chat = Chat.create_chat(chat_params, user)
      else
        new_att =  Attachment.new(:att => file)
        if ext == ".jpg"
          new_att.att_type = IMAGE
          new_atts << new_att
        elsif ext == ".m4a"
          new_att.att_type = AUDIO
          new_atts << new_att
        elsif ext == ".mp4"
          new_att.att_type = VIDEO
          new_atts << new_att
        end
      end
    end

    if new_chat
      new_atts.each do |att|
        new_chat.attachments << att
        att.save
      end
      return new_chat
    else
      return
    end
	end
end
