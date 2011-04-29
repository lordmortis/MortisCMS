require "mortiscms"
require "rails"

module Mortiscms
	class Engine < Rails::Engine			
		rake_tasks do
		  load "railties/tasks.rake"
		end
		
		Mime::Type.register_alias "text/html", :mobile
	end

	class Configuration
		attr_accessor :content_admin_route
		
		def new
			self.content_admin_route = {:controller => :index, :action => :admin}
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