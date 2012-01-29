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
				"<a href='#{file.data.url}'>#{$~[2]}</a>"
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
				if size == ""
					size = nil
				elsif size != "large" and size != "medium" and size != "small"
					size = nil
				else
					size = size.to_sym
				end
				image_size = image.data.image_size(size)
				width = image_size.split('x')[0]
				height = image_size.split('x')[1]
				"<img src='#{image.data.url(size)}' width='#{width}' height='#{height}'/>"
			end
		end
	end
end

RedCloth.send(:include, MortiscmsRedclothExtensions)