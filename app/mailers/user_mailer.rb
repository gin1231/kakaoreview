class UserMailer < ActionMailer::Base
	def receive(email)
		logger.info email
	end
end
