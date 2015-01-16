class ContentMailer < ActionMailer::Base
  default from: Mortiscms.config.publish_from_friendly_address, 
      return_path: Mortiscms.config.publish_from_address
    helper :mortiscms

  def mail(headers = {}, &block)
    if Rails.env == "staging" || Rails.env == "development"
      if request.env["action_controller.instance"].methods.include? :current_user
        current_user = request.env["action_controller.instance"].current_user
      end
      if current_user.present?
        headers["X-original-to"] = headers[:to]
        headers[:to] = current_user.email
        if headers[:cc].present?
          headers["X-original-cc"] = headers[:cc]
          headers[:cc] = nil
        end
        if headers[:bcc].present?
          headers["X-original-bcc"] = headers[:bcc]
          headers[:bcc] = nil
        end
        super(headers)
      else
        print "WARNING: COULD NOT FIND CURRENT USER\n"
      end
    else
      super(headers)
    end
  end

  def publish_block(block, name, email)
    @block = block
    @name = name
    mail(:to => email, subject: block.title)
  end
end
