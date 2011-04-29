require 'rails/generators'
require 'rails/generators/migration'

module Mortiscms
	module Generators
		class InstallGenerator < Rails::Generators::Base
			include Rails::Generators::Migration
			@@increment = 0
			def self.source_root
				@source_root ||= File.join(File.dirname(__FILE__), 'templates')
			end

			def content_blocks_migration
				migration_template 'contentblocks.rb', 'db/migrate/create_content_blocks.rb'
			end
	
			def content_pages_migration
				migration_template 'contentpages.rb', 'db/migrate/create_content_pages.rb'
			end
	
			def content_tags_migration
				migration_template 'contenttags.rb', 'db/migrate/create_content_tags.rb'
			end
	
			def content_tag_blocks_migration
				migration_template 'contenttagblocks.rb', 'db/migrate/create_content_tag_blocks.rb'
			end
			
      def copy_initializer
        copy_file 'mortiscms_initializer.rb', 'config/initializers/mortiscms.rb'
      end			
			
			private 
			
			def self.next_migration_number(dirname)
				if ActiveRecord::Base.timestamped_migrations
					@@increment += 1
					Time.now.utc.strftime("%Y%m%d%H%M%S#{@@increment}")
				else
					"%.3d" % (current_migration_number(dirname) + 1)
				end
			end
		
		end
	end
end
