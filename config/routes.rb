Rails.application.routes.draw do |map|
	map.connect 'page/:id', :controller => "content_viewer", :action => "page"
	map.connect 'blocks', :controller => "content_viewer", :action => "blocks"	
	map.connect 'article/:id', :controller => "content_viewer", :action => "content"	
	map.connect 'tag/:id', :controller => "content_viewer", :action => "tag"	
  map.resources :content_blocks, :collection => { :preview => :post }, :member => { :publish => :get, :unpublish => :get}
  map.resources :content_tags
  map.resources :content_pages	
end