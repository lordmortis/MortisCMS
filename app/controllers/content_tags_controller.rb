class ContentTagsController < MortiscmsControllerBase
	helper :mortiscms

  def index
    @tags = ContentTag.all
    user_authorize! :see, ContentTag

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  def show
		@tag = ContentTag.find(params[:id])
    user_authorize! :see, @tag
    redirect_to controller: :content_viewer, action: :tag, id: @tag.name.downcase
  end

  def new
    @tag = ContentTag.new
    user_authorize! :edit, @tag

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  def edit
    @tag = ContentTag.find(params[:id])
    user_authorize! :edit, @tag
  end

  def create
    @tag = ContentTag.new(editable_params)
    user_authorize! :edit, @tag
    respond_to do |format|
      if @tag.save
        flash[:notice] = 'Tag was successfully created.'
        format.html { redirect_to(@tag) }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def update
    @tag = ContentTag.find(params[:id])
    user_authorize! :edit, @tag
    respond_to do |format|
      if @tag.update_attributes(editable_params)
        flash[:notice] = 'Tag was successfully updated.'
        format.html { redirect_to(@tag) }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def destroy
    @tag = ContentTag.find(params[:id])
    user_authorize! :destroy, @tag
    @tag.destroy

    respond_to do |format|
      format.html { redirect_to(content_tags_url) }
    end
  end

private
  def editable_params
    params.require(:content_tag).permit(:name)
  end
end
