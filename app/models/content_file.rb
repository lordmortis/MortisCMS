class ContentFile < ActiveRecord::Base
	attachment_virtual_path = "/system/attachments/:rails_env/:hashed_path/:id/:style/:basename.:extension"
	attachment_real_path = ":rails_root/public" + attachment_virtual_path

	belongs_to :author, :class_name => Mortiscms.config.user_model
	default_scope :order => "created_at desc"

	do_not_validate_attachment_file_type :data
	has_attached_file :data, path: attachment_real_path, url: attachment_virtual_path
end
