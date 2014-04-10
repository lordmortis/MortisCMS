class ContentImagesController < MortiscmsControllerBase
	filter_access_to :all
	helper :mortiscms
	
	def index
		@images = ContentImage.all

		respond_to do |format|
			format.html # index.html.erb
			format.mobile # index.mobile.erb
			format.json { render :json => {:ids => @images.collect { |block| block.id } } }
		end
	end
	
	def show
		@image = ContentImage.find(params[:id])

		respond_to do |format|
			format.html # show.html.erb
			format.mobile # index.mobile.erb
		end
	end

	def new
		@image = ContentImage.new

		respond_to do |format|
			format.html # new.html.erb
			format.mobile # index.mobile.erb
		end
	end

	def edit
		@image = ContentImage.find(params[:id])
	end

	def create
		@image = ContentImage.new(params[:content_image])
		@image.author = current_user
		respond_to do |format|
			if @image.save
				flash[:notice] = 'Image was successfully created.'
				format.html { redirect_to(@image) }
			else
				format.html { render :action => "new" }
			end
		end
	end

	def update
		@image = ContentImage.find(params[:id])
		respond_to do |format|
			if @image.update_attributes(params[:content_image])
				flash[:notice] = 'Image was successfully updated.'
				format.html { redirect_to(@image) }
			else
				format.html { render :action => "edit" }
			end
		end
	end

	def destroy
		@images = ContentImage.find(params[:id])
		@images.destroy

		respond_to do |format|
			format.html { redirect_to(content_images_url) }
		end
	end	
end
