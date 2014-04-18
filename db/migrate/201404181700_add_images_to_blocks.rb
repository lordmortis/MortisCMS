class AddImagesToBlocks < ActiveRecord::Migration
	def change
		add_column :content_blocks, :reference, :content_images
	end
end
