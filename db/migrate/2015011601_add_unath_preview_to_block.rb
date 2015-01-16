class AddUnathPreviewToBlock < ActiveRecord::Migration
  def change
    add_column :content_blocks, :preview_hash, :string, null: true
    ContentBlock.all.each do |block|
      block.generate_hash
      block.save
    end
  end
end
