class ContentMailer < ActionMailer::Base
	default :from => Mortiscms.config.email_from_address
  	helper :mortiscms

  	def publish_block(block, name, email)
  		@block = block
  		@name = name
  		mail(:to => email, subject: block.summary)
  	end
end
