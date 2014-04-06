Rails.application.routes.draw do 
	match 'content/hidden' => 'content_viewer#not_public', via: [:get]
	match 'content/:id' => 'content_viewer#page', via: [:get]
	match 'content/article/:id' => 'content_viewer#content', via: [:get]
	match 'content/tag/:id' => 'content_viewer#tag', via: [:get]
		
	if Mortiscms.config.routes_enabled

		resources :content_blocks do
			collection do
				post :preview
			end

			member do
				post :publish
				post :unpublish
			end
		end

		resources :content_tags
		resources :content_pages
		resources :content_files
		resources :content_images

	end
end
