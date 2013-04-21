Mortiscms.setup do |config|

# Configure default route if there is no content
#	config.content_admin_route = {:controller => "index", :action => "admin"}	
end

print "INIT"

Rails.application.class.config.assets.paths << File.join(File.expand_path(File.dirname(__FILE__)), 'assets')