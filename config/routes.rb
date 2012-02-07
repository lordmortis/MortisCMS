Rails.application.routes.draw do 
	match 'content/hidden' => 'content_viewer#not_public'
	match 'content/:id' => 'content_viewer#page'
	match 'content/article/:id' => 'content_viewer#content'
	match 'content/tag/:id' => 'content_viewer#tag'
		
	if Mortiscms.config.routes_enabled

		resources :content_blocks do
			collection do
				post :preview
			end

			member do
				get :publish
				get :unpublish
			end
		end

		resources :content_tags
		resources :content_pages
		resources :content_files
		resources :content_images

	end
end