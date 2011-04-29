class ContentViewerController < ApplicationController
	helper :mortiscms
	
	def page
		@page = nil
		if params[:id] != nil
			@page = ContentPage.where(:name => params[:id].downcase).first
		else
			@page = ContentPage.where(:home => true).first
			if @page != nil
				render :action => "content", :id => @page.block.id
				return
			end
		end
		
		if @page == nil
			redirect_to Mortiscms.config.content_admin_route
			return
		elsif	@page.block != nil
			@block = @page.block
			render :action => "content", :id => @page.block.id
			return
		end
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
end
