class ContentFilesController < MortiscmsControllerBase
	helper :mortiscms
	
	def index
		@files = ContentFile.all
		user_authorize! :see, ContentFile

		respond_to do |format|
			format.html # index.html.erb
			format.mobile # index.mobile.erb
			format.json { render :json => {:ids => @blocks.collect { |block| block.id } } }
		end
	end

	def show
		@file = ContentFile.find(params[:id])
		user_authorize! :see, @file

		respond_to do |format|
			format.html # show.html.erb
			format.mobile # index.mobile.erb
		end
	end

	def new
		@file = ContentFile.new
		user_authorize! :edit, @file

		respond_to do |format|
			format.html # new.html.erb
			format.mobile # index.mobile.erb
		end
	end

	def edit
		@file = ContentFile.find(params[:id])
		user_authorize! :edit, @file
	end

	def create
		@file = ContentFile.new(editable_params)
		user_authorize! :edit, @file
		@file.author = current_user
		respond_to do |format|
			if @file.save
				flash[:notice] = 'File was successfully created.'
				format.html { redirect_to(@file) }
			else
				format.html { render :action => "new" }
			end
		end
	end

	def update
		@file = ContentFile.find(params[:id])
		user_authorize! :edit, @file
		respond_to do |format|
			if @file.update_attributes(editable_params)
				flash[:notice] = 'File was successfully updated.'
				format.html { redirect_to(@block) }
			else
				format.html { render :action => "edit" }
			end
		end
	end

	def destroy
		@file = ContentFile.find(params[:id])
		user_authorize! :destroy, @file
		@file.destroy

		respond_to do |format|
			format.html { redirect_to(content_files_url) }
		end
	end	

private
  def editable_params
    params.require(:content_file).permit(:data, :description)
  end
end
