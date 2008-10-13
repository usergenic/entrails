# TemplateForReferer, when included in ActionController::Base patches the built-in
# default_template_name method, which is used to determine what template to use in
# the app/views folder.  It does this so that we can create special templates to
# respond to requests coming from specific named routes.
#
# Why?  This can be useful when managing responses for requests coming to the same
# controller action from multiple contexts.  This was created primarily to deal with
# context in an AJAX setting, where the javascript returned by an RJS file will
# depend on the current page in the browser, since you may be changing DOM structures
# specific to that page.
#
# Consider a social network site where you want to support giving users the ability
# to friend each other.  You'll probably have a friendships resource which will respond
# to a post method, and you may want to support doing so via AJAX.  Well in one case 
# there may be an "add as friend" button on the user profile, which reacts by flipping
# the button to "remove friend".  In another case you may have many buttons in a list
# which respond by redrawing the list and adding the new friend in another list.
#
# The solution provided by this module is to allow you to define templates based on
# the named_route from which the request is being issued/refered.  So in the case of
# the button on the user profile, which would probably by the 'user' named route,
# you would define a create_for_user.js.rjs template to handle it in app/views/friendships.
# In the case of the list, say the users named route (i.e. the index of users),
# app/views/friendships/create_for_users.js.rjs
#
# If there is no specific template for the referer's named route or if the referer
# is not the local application, (determined by request.host) then we just revert to
# the default_template_name originally provided by Rails.
#
# Note that this behavior is not enabled just for rjs templates-- You can use it for
# any formats.  
#
# Rails uses the controller and action names to determine the
# name of the template to load.
module Entrails::ActionController::TemplateForReferer
  
  private
  
  def default_template_name_with_template_for_referer
    template_name = default_template_name_without_template_for_referer
    template_name_for_referer = "#{template_name}_for_#{referer_named_route}"
    return template_name_for_referer if template_exists?(template_name_for_referer)
    template_name
  end
  
  def referer_host
    URI.parse(request.referer).host unless request.referer.blank?
  end

  def referer_host_local?
    referer_host == request.host
  end
  
  def referer_named_route
    referer_params[:named_route]
  rescue
    nil
  end 

  def referer_params
    (ActionController::Routing::Routes.recognize_path(referer_path, :method => :get) if referer_host_local?) || {}
  rescue
    {}
  end

  def referer_path
    URI.parse(request.referer).path unless request.referer.blank?
  end
  
  def self.included(host)
    host.alias_method_chain :default_template_name, :template_for_referer
  end
  
end
