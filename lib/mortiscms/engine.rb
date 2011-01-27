require "mortiscms"
require "rails"

module Mortiscms
	class Engine < Rails::Engine
		
		rake_tasks do
		  load "railties/tasks.rake"
		end
		
		Mime::Type.register_alias "text/html", :mobile
	end
end