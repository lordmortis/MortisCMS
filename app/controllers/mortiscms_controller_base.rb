class MortiscmsControllerBase < ApplicationController
  def user_authorize!(action, object)
    unless action.to_s.ends_with?("?")
      action = "#{action.to_s}?"
    end

    if Mortiscms.config.authorization_system == :pundit
      authorize object, action.to_sym
    end
  end

  def user_authorize(action, object)
    begin
      user_authorize!(action, object)
    rescue
      return false
    end
    return true
  end

	def user_can?(action, object)
		unless action.to_s.ends_with?("?")
			action = "#{action.to_s}?"
		end

		if Mortiscms.config.authorization_system == :pundit
			policy(object).send(action)
		end	
	end
end
