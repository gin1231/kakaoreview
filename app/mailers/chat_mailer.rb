class ChatMailer < ActionMailer::Base
	def receive(message)
		attachment = message.attachments.first

		Chat.create do |chat|
			file = StringIO.new(attachment.body.decoded)
			file.class.class_eval {attr_accessor :original_filename, :content_type}
			file.original_filename = attachment.filename
			file.content_type = attachment.mime_type

			chat.title = message.subject
			chat.chatfile = file
			chat.user = User.find_by_username(message.to[0].split("@")[0])
		end

	end
end
