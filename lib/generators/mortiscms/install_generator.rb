require 'rails/generators'
require 'rails/generators/migration'

module Mortiscms
	module Generators
		class InstallGenerator < Rails::Generators::Base
			def copy_initializer
				copy_file 'mortiscms_initializer.rb', 'config/initializers/mortiscms.rb'
			end
		end
	end
end
