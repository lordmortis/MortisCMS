require "RedCloth"
require "paperclip"
require "paperclip-meta"
require "mortiscms"
require "rails"
require "mortiscms_redcloth"

module Mortiscms
	class Engine < Rails::Engine			
		rake_tasks do
		  load "railties/tasks.rake"
		end
		
		Mime::Type.register_alias "text/html", :mobile
	end

	class Configuration
		attr_accessor :content_admin_route, :site_name, :show_titles_in_pages, :email_from_address,
						:show_titles_in_tags, :routes_enabled, :user_model, :link_root, :publish_to_email
		
		def new
			self.content_admin_route = {:controller => :index, :action => :admin}
			self.site_name = "MortisCMS Site"
			self.show_titles_in_pages = false
			self.show_titles_in_tags = false
			self.routes_enabled = true
			self.user_model = "User"
			self.publish_to_email = false
			self.email_from_address = "junk@place.com"
			self.link_root = ""
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