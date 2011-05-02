class ContentPage < ActiveRecord::Base
	belongs_to :tag, :class_name => "ContentTag", :foreign_key => "content_tag_id"
	belongs_to :block, :class_name => "ContentBlock", :foreign_key => "content_block_id"
	
  attr_accessible :content_block_id, :content_tag_id, :name, :home, :order_index, :navbar

	scope :topbar, :order => ["order_index"], :conditions => ["navbar = ?", true]

	before_save :check_home, :downcase_name
	
	def check_home
		if self.home
			cparelid = ContentPage.arel_table[:id]
			ContentPage.where(:home => true).where(cparelid.not_eq(self.id)).all.each do |otherpage|
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
