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
