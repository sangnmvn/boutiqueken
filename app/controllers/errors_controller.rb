class ErrorsController < ApplicationController
  layout "application_error_code"
  def not_found
    render(:status => 404)
  end

  def internal_server_error
    render(:status => 500)
  end
end
