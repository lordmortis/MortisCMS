class ContentMailer < ActionMailer::Base
	default from: Mortiscms.config.publish_from_friendly_address, 
			return_path: Mortiscms.config.publish_from_address
  	helper :mortiscms

  	def publish_block(block, name, email)
  		@block = block
  		@name = name
  		mail(:to => email, subject: block.title)
  	end
end
