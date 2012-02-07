require 'rails/generators'
require 'rails/generators/migration'

module Mortiscms
	class InstallGenerator < Rails::Generators::Base
		def self.source_root
			@source_root ||= File.join(File.dirname(__FILE__), 'templates')
		end

		def copy_initializer
			copy_file 'mortiscms_initializer.rb', 'config/initializers/mortiscms.rb'
			copy_file 'publish_block.html.erb', 'views/content_mailer/publish_block.html.erb'
			copy_file 'publish_block.text.erb', 'views/content_mailer/publish_block.text.erb'
		end
	end
end
