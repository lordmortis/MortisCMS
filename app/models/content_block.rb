class ContentBlock < ActiveRecord::Base
#	has_paper_trail
	include MortiscmsHelper

	belongs_to :editor, :class_name => Mortiscms.config.user_model
	belongs_to :author, :class_name => Mortiscms.config.user_model
	belongs_to :content_image

	has_many :taglinks, :class_name => "ContentTagBlock", :foreign_key => "content_block_id"
	has_many :tags, :class_name => "ContentTag", :through => :taglinks
	has_many :pages, :class_name => "ContentPage", :foreign_key => "content_block_id"

	default_scope { order(published_at: :desc) }

	before_save :generate_preview_hash

	def image
		content_image
	end

	def image=(value)
		self.content_image = value
	end

	def publish(link, editor = nil, email)
		self.published_at = Time.now

		if editor != nil
			self.editor = editor
		end

		if Mortiscms.config.publish_to_email != false and email
			query = Mortiscms.config.publish_to_email[:query]
			namemethod = Mortiscms.config.publish_to_email[:name]
			emailmethod = Mortiscms.config.publish_to_email[:email]
			if Rails.env.production?
				query.each do |person|
					name = person.send(namemethod)
					email = person.send(emailmethod)
					if email != nil and email.strip != ""
						ContentMailer.publish_block(self, name, email).deliver
					end
				end
				if Mortiscms.config.publish_extra_emails != nil
					Mortiscms.config.publish_extra_emails.each do |email|
						ContentMailer.publish_block(self, email[0], email[1]).deliver
					end
				end
			else
				if editor.present?
					ContentMailer.publish_block(self, editor.send(namemethod), editor.send(emailmethod)).deliver
				end
			end
		end

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
		self.published_at = nil

		# Remove tweet.
#		if (self.tweet_id != nil and ContentTwitterLib::Setup.Working)
#			twittercreds = YAML.load_file("config/authlogic.yml")["connect"]["twitter"]
#			oauth = Twitter::OAuth.new(twittercreds["key"], twittercreds["secret"])
#			oauth.authorize_from_access(twittercreds["master_account_token"], twittercreds["master_account_secret"])

#			client = Twitter::Base.new(oauth)
#			begin
#				client.status_destroy(self.tweet_id)
#				self.tweet_id = nil
#			rescue Twitter::NotFound => boom
#				self.tweet_id = nil
#			end
#		end
#
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
			atag = ContentTag.find_by_name(newtag.downcase)
			if atag == nil
				atag = ContentTag.new(:name => newtag.downcase)
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

	def published
		self.published_at != nil
	end

	def public?
		self.published_at != nil
	end

	def self.publicly_viewable
		where("content_blocks.published_at IS NOT NULL")
	end

private
	def generate_preview_hash
		self.preview_hash = SecureRandom.hex
	end
end
