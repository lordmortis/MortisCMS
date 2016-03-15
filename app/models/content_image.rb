class ContentImage < ActiveRecord::Base
	attachment_virtual_path = "/system/attachments/:rails_env/:hashed_path/:id/:style/:basename.:extension"
	attachment_real_path = ":rails_root/public" + attachment_virtual_path

	belongs_to :author, :class_name => Mortiscms.config.user_model
	default_scope { order(created_at: :desc) }

	has_attached_file :data, path: attachment_real_path, url: attachment_virtual_path, styles: { small: "64x64>", medium: "128x128>", large: "256x256>" }
	validates_attachment :data, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }
end
