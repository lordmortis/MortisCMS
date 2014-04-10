class MortiscmsControllerBase < ApplicationController
  def user_authorize!(action, object)
    unless action.to_s.ends_with?("?")
      action = "#{action.to_s}?"
    end

    if Mortiscms.config.authorization_system == :pundit
      authorize object, action.to_sym
    end
  end
end
