Rails.application.routes.draw do 
	match 'page/:id' => 'content_viewer#page'
	match 'blocks' => 'content_viewer#blocks'
	match 'article/:id' => 'content_viewer#content'
	match 'tag/:id' => 'content_viewer#tag'
	
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
end