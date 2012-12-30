class EmailsController < ApplicationController
	skip_before_filter :verify_authenticity_token

	def create
		if params[:mail]
			chat = ChatMailer.receive(Mail.new(params[:mail]))

			if !chat.new_record?
				render :text => "Success", :status => 201, :content_type => Mime::TEXT.to_s
			else
				render :text => chat.errors.full_messages.join(', '), :status => 422, :content_type => Mime::TEXT.to_s
			end
		end
	end
end
