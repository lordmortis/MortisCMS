class CreateContentImages < ActiveRecord::Migration
	def change
		create_table :content_images do |t|
			t.integer :author_id
			t.string :description
			t.string :data_file_name
			t.string :data_content_type
			t.integer :data_file_size
			t.datetime :data_updated_at
			t.integer :data_height
			t.integer :data_width
			t.string :data_fingerprint
			t.text :data_meta
			t.timestamps
		end
	end
end