# Methods added to this helper will be available to all templates in the application.
module MortiscmsHelper
	def tag_list(object)
		value = ""
		for tag in object.tags
			value += link_to(tag.name, tag)
			value += ", "
		end
		if value != ""
			value = value[0..-3]
		end
		
		value
	end
	
	def page_list(object)
		value = ""
		for page in object.pages
			value += link_to(page.name, page)
			value += ", "
		end
		if value != ""
			value = value[0..-3]
		end
		
		value
	end
	
	def render_time(content, format = "%H:%M on %b %d, %Y")
		content.strftime(format)
	end

	def render_tag_link(tag)
		link_to(tag.name.capitalize, action: "tag", id: tag.name)
	end

	def contentlink(content)
		link_to(:action => "content", :controller => "content_viewer", :id => content.id)
	end

	def redcloth_render(content)
		parser = RedCloth.new(content)
		raw parser.to_html(:mortiscms_localfile, :mortiscms_localimage, :textile, :markdown)
	end

	def user_can?(action, object)
		unless action.to_s.ends_with?("?")
			action = "#{action.to_s}?"
		end

		if Mortiscms.config.authorization_system == :pundit
			policy(object).send(action)
		end	
	end
end
