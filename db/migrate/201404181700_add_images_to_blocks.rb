class AddImagesToBlocks < ActiveRecord::Migration
	def change
		add_column :content_blocks, :content_image_id, :integer
	end
end
