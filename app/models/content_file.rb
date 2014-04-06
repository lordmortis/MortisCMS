class ContentFile < ActiveRecord::Base
#	has_paper_trail
	
	attachment_virtual_path = "/system/attachments/:rails_env/:hashed_path/:id/:style/:basename.:extension"
	attachment_real_path = ":rails_root/public" + attachment_virtual_path

	belongs_to :author, :class_name => Mortiscms.config.user_model
	default_scope :order => "created_at desc"

	has_attached_file :data, path: attachment_real_path, url: attachment_virtual_path

# TODO: Replace with Strong Params
#	attr_accessible :data_file_name, :description

end
