class ContentTag < ActiveRecord::Base
	has_many :taglinks, :class_name => "ContentTagBlock", :foreign_key => "content_tag_id"
	has_many :blocks, -> { order(updated_at: :desc) }, :class_name => "ContentBlock", :through => :taglinks
	has_many :pages, :class_name => "ContentPage", :foreign_key => "content_tag_id"

	before_save :downcase_name

	def downcase_name
		self.name = name.downcase
		true
	end

	def page?
		pages.count > 0
	end

	def public?
		true
	end
end
