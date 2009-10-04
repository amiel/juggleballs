# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  
  before_filter :local
  def local
    @local_request = local_request?
    true
  end
end
