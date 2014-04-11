class ContentViewerController < MortiscmsControllerBase
	helper :mortiscms
	
	def homepage
		@page = ContentPage.where(:home => true).first
		render_page
	end

	def page
		@page = ContentPage.where(:name => params[:id].downcase).first
		render_page
	end
	
	def content
		@block = ContentBlock.find(params[:id])
		if @block == nil
			redirect_to :action => "section"
		else
			if !@block.public? and !current_user.send(Mortiscms.config.writer_query_message)
				redirect_to action: :not_public
			end
		end
	end

	def tag
		@tag = ContentTag.find_by_name(params[:id])

		if @tag == nil
			redirect_to :action => "section"
			return
		end

		@name = @tag.name
		if user_can? :edit?, ContentBlock
			@collection = @tag.blocks
		else
			@collection = @tag.blocks.publicly_viewable
		end
	end

private

	def render_page
		if @page == nil
			redirect_to Mortiscms.config.content_admin_route
			return
		elsif @page.controller != nil
				if @page.action != nil
					redirect_to :action => @page.action, :controller => @page.controller
				else
					redirect_to :controller => @page.controller, :action => "index"
				end
				return
		elsif @page.block != nil
			@block = @page.block
			if !@block.public? and !user_can? :edit, @block
				redirect_to action: :not_public
			else
				render :action => "content", :id => @page.block.id
			end
			return
		end

		@tag = @page.tag
		@name = @tag.name

		if user_can? :edit, ContentBlock
			@collection = @tag.blocks
		else
			@collection = @tag.blocks.publicly_viewable
		end

		render "tag"
	end
end
