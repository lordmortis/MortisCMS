class ContentPagesController < MortiscmsControllerBase
	filter_resource_access
	helper :mortiscms

  def index
    @content_pages = ContentPage.proper_order.all
  end
  
  def show
    @content_page = ContentPage.find(params[:id])
    redirect_to controller: :content_viewer, action: :page, id: @content_page.name.downcase
  end
  
  def new
    @content_page = ContentPage.new
  end
  
  def create
    @content_page = ContentPage.new(page_params)
    if @content_page.save
      flash[:notice] = "Successfully created content page."
      redirect_to @content_page
    else
      render :action => 'new'
    end
  end
  
  def edit
    @content_page = ContentPage.find(params[:id])
  end
  
  def update
    @content_page = ContentPage.find(params[:id])
    if @content_page.update_attributes(page_params)
      flash[:notice] = "Successfully updated content page."
      redirect_to @content_page
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @content_page = ContentPage.find(params[:id])
    @content_page.destroy
    flash[:notice] = "Successfully destroyed content page."
    redirect_to content_pages_url
  end

private
  def page_params
    params.require(:content_page).permit!
  end
end
