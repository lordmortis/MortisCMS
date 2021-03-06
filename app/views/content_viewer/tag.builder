xml.instruct! :xml, :version=>"1.0" 
xml.rss(:version=>"2.0"){
  xml.channel{
 		xml.title("#{Mortiscms.config.site_name} - RSS feed - #{@name.capitalize}")
		xml.link(url_for(:action => "tag", :controller => "content_viewer", :id => @tag.name, :skip_relative_url_root => true))
    xml.description("Items tagged with #{@tag.name}")
    xml.language("en-AU")
    for block in @tag.blocks
      xml.item do
        xml.title(block.title)
				xml.description(block.summary)
#				xml.author_name(article.user.name)
#				xml.author_picture(avatarlink(article.user))
        xml.pubDate(block.created_at.rfc2822)
      	xml.guid(url_for(:action => "content", :controller => "content_viewer", :id => block.id, :skip_relative_url_root => true))
      end
    end
  }
}