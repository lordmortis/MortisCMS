class ContentImagesController < MortiscmsControllerBase
	helper :mortiscms
	
	def index
		@images = ContentImage.all
		user_authorize! :see, ContentImage

		respond_to do |format|
			format.html # index.html.erb
			format.mobile # index.mobile.erb
			format.json { render :json => {:ids => @images.collect { |block| block.id } } }
		end
	end
	
	def show
		@image = ContentImage.find(params[:id])
		user_authorize! :see, @image

		respond_to do |format|
			format.html # show.html.erb
			format.mobile # index.mobile.erb
		end
	end

	def new
		@image = ContentImage.new
		user_authorize! :edit, @image

		respond_to do |format|
			format.html # new.html.erb
			format.mobile # index.mobile.erb
		end
	end

	def edit
		@image = ContentImage.find(params[:id])
		user_authorize! :edit, @image
	end

	def create
		@image = ContentImage.new(editable_params)
		user_authorize! :edit, @image
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
		user_authorize! :edit, @image
		respond_to do |format|
			if @image.update_attributes(editable_params)
				flash[:notice] = 'Image was successfully updated.'
				format.html { redirect_to(@image) }
			else
				format.html { render :action => "edit" }
			end
		end
	end

	def destroy
		@image = ContentImage.find(params[:id])
		user_authorize! :destroy, @image
		@image.destroy

		respond_to do |format|
			format.html { redirect_to(content_images_url) }
		end
	end	

private
  def editable_params
    params.require(:content_image).permit(:data, :description)
  end
end
