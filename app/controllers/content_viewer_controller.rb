class ContentViewerController < ApplicationController
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
		end
	end

	def tag
		@tag = ContentTag.find_by_name(params[:id])
		if @tag == nil
			redirect_to :action => "section"
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
		elsif	@page.block != nil
			@block = @page.block
			render :action => "content", :id => @page.block.id
			return
		end

		render "page"
	end
end
