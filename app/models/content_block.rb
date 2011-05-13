class ContentBlock < ActiveRecord::Base
#	has_paper_trail
	
	belongs_to :editor, :class_name => "User"
	belongs_to :author, :class_name => "User"

	has_many :taglinks, :class_name => "ContentTagBlock", :foreign_key => "content_block_id"
	has_many :tags, :class_name => "ContentTag", :through => :taglinks
	has_many :pages, :class_name => "ContentPage", :foreign_key => "content_block_id"
	
	default_scope :order => "created_at desc"
	
	attr_accessible :summary, :autosummarize, :preview, :bodytext, :tag_list, :title

	before_save :blank_to_null
	
	def blank_to_null
		nullarray = [:controller, :action]
			
		nullarray.each do |attr|
			if self[attr] != nil
				self[attr] = self[attr].strip
				if self[attr] == ""
					self[attr] = nil
				end
			end
		end
	end
	
	def html
		RedCloth.new(bodytext).to_html		
	end
	
	def publish(link)
		self.published = true
#  FIXME : needs to work with new engine!		
#		if (self.short_url == nil && File.exist?("config/bitly.yml"))
#			bitlycreds = YAML.load_file("config/bitly.yml")["bitly"]
#			bitly = Bitly.new(bitlycreds["username"], bitlycreds["secret"])
#			self.short_url = bitly.shorten(link).short_url
#		end
		
		
#		if (self.tweet_id == nil and ContentTwitterLib::Setup.Working)
#			twittercreds = YAML.load_file("config/authlogic.yml")["connect"]["twitter"]
#			oauth = Twitter::OAuth.new(twittercreds["key"], twittercreds["secret"])
#			oauth.authorize_from_access(twittercreds["master_account_token"], twittercreds["master_account_secret"])
#			client = Twitter::Base.new(oauth)
#			self.tweet_id = client.update("#{self.summary} #{self.short_url}").id
#		end
		
		# do LJ publishing
		self.save
	end
	
	def unpublish
		self.published = false
		
		# Remove tweet.
		if (self.tweet_id != nil and ContentTwitterLib::Setup.Working)
			twittercreds = YAML.load_file("config/authlogic.yml")["connect"]["twitter"]
			oauth = Twitter::OAuth.new(twittercreds["key"], twittercreds["secret"])
			oauth.authorize_from_access(twittercreds["master_account_token"], twittercreds["master_account_secret"])

			client = Twitter::Base.new(oauth)
			begin
				client.status_destroy(self.tweet_id)
				self.tweet_id = nil
			rescue Twitter::NotFound => boom
				self.tweet_id = nil
			end
		end
		
		# Remove LJ post.
		self.save
	end
		
	def tag_list()
		value = ""
		for tag in tags
			value += tag.name
			value += ", "
		end
		if value != ""
			value = value[0..-3]
		end
		
		value
	end

	def page_list()
		value = ""
		for page in pages
			value += page.name
			value += ", "
		end
		if value != ""
			value = value[0..-3]
		end
		
		value
	end
	
	def tag_list=(value)
		list = value.split(",")
		newlist = []
		for item in list
			newlist << item.strip
		end
		
		list = newlist

		for taglink in taglinks
			if !list.include?(taglink.tag.name)
				taglink.destroy
			else
				list.delete(taglink.tag.name)
			end
		end
		
		for newtag in list
			atag = ContentTag.find_by_name(newtag)
			if atag == nil
				atag = ContentTag.new(:name => newtag)
				atag
			end
			
			tags << atag
			
		end
	end
		
	def do_autosummarize
		if bodytext.size <= 160
			self.summary = bodytext
		else
			self.summary = bodytext[0..156] + "..."
		end
	end
end
