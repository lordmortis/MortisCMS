class ContentPage < ActiveRecord::Base
	belongs_to :tag, :class_name => "ContentTag", :foreign_key => "content_tag_id"
	belongs_to :block, :class_name => "ContentBlock", :foreign_key => "content_block_id"
	
  attr_accessible :content_block_id, :content_tag_id, :name, :home, :order_index, :navbar

	named_scope :topbar, :order => ["order_index"], :conditions => ["navbar = ?", true]

	before_update :check_home, :downcase_name
	
	def check_home
		if self.home
			for otherpage in ContentPage.find_all_by_home(true)
				otherpage.home = false
				otherpage.save
			end
		end
		true
	end

	def downcase_name
		self.name = name.downcase
		true
	end
end
