class ApplicationController < ActionController::Base
  rescue_from StandardError do |exception|
    whitelisted = [Mongoid::Errors::Validations]
    is_displayable = whitelisted.include?(exception.class)

    message = exception.message
    message = exception.summary if exception.respond_to?(:summary)
    message.gsub!('The following errors were found: ', '')

    render json: {
      success: false,
      errors: {base: message},
      displayable_error: is_displayable
    }
  end

  protect_from_forgery with: :exception
end
