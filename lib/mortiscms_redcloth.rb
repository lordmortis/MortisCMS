unless RedCloth
  require 'RedCloth'
end

module MortiscmsRedclothExtensions
	def mortiscms_localfile(text)
		text.gsub!(/!localfile:(\d*):['"](([[:alnum:]]|[[:space:]])*)['"]!/) do |m|
			file = ContentFile.where(id: $~[1].to_i).first
			if file == nil
				$~[2]
			else
				"<a href='#{Mortiscms.config.link_root}#{file.data.url}'>#{$~[2]}</a>"
			end
		end
	end

	def mortiscms_localimage(text)
		text.gsub!(/!localimage:(\d*):*(\w*)!/) do |m|
			image = ContentImage.where(id: $~[1].to_i).first
			if image == nil
				"Image Not Found!"
			else
				size = $~[2].downcase
				if size == "large" or size == "medium" or size == "small"
					size = size.to_sym
				else
					size = nil
				end
				image_size = image.data.image_size(size)
				width = image_size.split('x')[0]
				height = image_size.split('x')[1]
				"<img src='#{Mortiscms.config.link_root}#{image.data.url(size)}' width='#{width}' height='#{height}'/>"
			end
		end
	end
end

RedCloth.send(:include, MortiscmsRedclothExtensions)