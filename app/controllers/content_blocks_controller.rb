class ContentBlocksController < ApplicationController
	filter_access_to :all
	helper :mortiscms
	
  def index
    @blocks = ContentBlock.find(:all)

    respond_to do |format|
      format.html # index.html.erb
			format.mobile # index.mobile.erb
			format.json { render :json => {:ids => @blocks.collect { |block| block.id } } }
    end
  end

	def preview
		render :text => view_context.redcloth_render(params[:redcloth])
	end
	
	def publish
		@block = ContentBlock.find(params[:id])
    email = false
    if params[:email]
      email = params[:email].downcase == "true"
    end
		@block.publish(url_for(:action => "content", :controller => "content_viewer", :id => @block.id, :skip_relative_url_root => true), current_user, email)
		redirect_to(@block)
	end
	
	def unpublish
		@block = ContentBlock.find(params[:id])
		@block.unpublish
		redirect_to(@block)
	end

  def show
		@block = ContentBlock.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
			format.mobile # index.mobile.erb
			format.json { render :json => {:block => { :id => @block.id, :html => @block.html } } }
		end
  end

  def new
    @block = ContentBlock.new

    respond_to do |format|
      format.html # new.html.erb
			format.mobile # index.mobile.erb
    end
  end

  def edit
    @block = ContentBlock.find(params[:id])
  end

  def create
    @block = ContentBlock.new(params[:content_block])
		@block.author = current_user
    respond_to do |format|
      if @block.save
        flash[:notice] = 'Block was successfully created.'
        format.html { redirect_to(@block) }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def update
    @block = ContentBlock.find(params[:id])
    respond_to do |format|
      if @block.update_attributes(params[:content_block])
        flash[:notice] = 'Block was successfully updated.'
        format.html { redirect_to(@block) }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def destroy
    @block = ContentBlock.find(params[:id])
    @block.destroy

    respond_to do |format|
			format.html { redirect_to(content_blocks_url) }
    end
  end	
end
