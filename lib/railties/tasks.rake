desc 'MortisCMS Tasks'

namespace :MortisCMS do
	desc 'Ensure all tags of the same name are the same tags'
	task :coalesce_tags => :environment do
		print "Coalescing tags..."
		names = ContentTag.all.collect { |item| {item.name => item.id } }
		idmap = Hash.new
		
		names.each do |item|	
			idmap.merge!(item)
		end
		
		ContentTag.all.each do |tag|
			if tag.id != idmap[tag.name]
				tag.taglinks.each do |link|
					link.content_tag_id = idmap[tag.name]
					link.save
				end
				
				tag.pages.each do |page|
					page.content_tag_id = idmap[tag.name]
					page.save
				end
				
				tag.destroy
				
			end
		end
		
	end
end