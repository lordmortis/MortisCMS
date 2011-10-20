require "mortiscms"
require "rails"

module Mortiscms
	class Engine < Rails::Engine			
		rake_tasks do
		  load "railties/tasks.rake"
		end
		
		Mime::Type.register_alias "text/html", :mobile
	end

	class ContentViewerConfiguration
		attr_accessor :page_list_titles, :tag_list_titles

		def new
			self.page_list_titles = false
			self.tag_list_titles = false
		end
	end

	class Configuration
		attr_accessor :content_admin_route, :site_name, :show_titles_in_pages, 
						:show_titles_in_tags, :routes_enabled
		
		def new
			self.content_admin_route = {:controller => :index, :action => :admin}
			self.site_name = "MortisCMS Site"
			self.show_titles_in_pages = false
			self.show_titles_in_tags = false
			self.routes_enabled = true
#			self.content_viewer = Mortiscms::ContentViewerConfiguration.new
		end
		
	end

	def self.config(&block)
		@@config ||= Mortiscms::Configuration.new

    yield @@config if block

    return @@config
	end
	
	def self.setup(&block)
		self.config(block)
	end

end