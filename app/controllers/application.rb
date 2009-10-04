# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  # Pick a unique cookie name to distinguish our session data from others'
  session :session_key => '_juggleballs_session_id'
  
  before_filter :local
  def local
    @local_request = local_request?
    true
  end
end
