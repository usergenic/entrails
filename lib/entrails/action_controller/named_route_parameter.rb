# NamedRouteParameter is currently in the "hack" phase because its implementation
# essentially creates a duplicate route in memory for every named_route defined.
# The purpose of this hack is really to be able to determine which named_route is
# being recognized by simply tacking on a new parameter called :named_route.
#
# This can be helpful in shared partials where you may only want to display
# something for certain views and it would be nice to determine it from the
# named route.  It is also very helpful if you need a concise standard name
# when analyzing the path from a local referer (indeed, this was the initial
# use case for its construction.)
#
module Entrails::ActionController::NamedRouteParameter
  
  def add_named_route_with_named_route_parameter(name, path, options = {})
    addition = add_named_route_without_named_route_parameter(name, path, options.merge(:named_route => name.to_s))
    add_route(path, options) # hack to allow generation from params that don't contain :named_route 
    addition
  end
  
  def self.included(host)
    host.alias_method_chain :add_named_route, :named_route_parameter
  end
  
end
