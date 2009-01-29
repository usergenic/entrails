module Entrails
  VERSION='1.0.5'
  AUTHORS=["Brendan Baldwin"]
  EMAIL=["brendan@usergenic.com"]
  DESCRIPTION=%q{This is a collection of extensions to Rails internals that I've found to be absolutely indispensible since I implimented them.  The real action is happening in the following two files at the moment: http://github.com/brendan/entrails/tree/master/lib/entrails/active_record/better_conditions.rb http://github.com/brendan/entrails/tree/master/lib/entrails/active_record/find_by_association.rb}
  FOLDER=File.expand_path(File.join(File.dirname(__FILE__),'..'))
  MANIFEST=Dir.glob(File.join(FOLDER,'**','*')).map{|path|path[FOLDER.size+1..-1]}
  HOMEPAGE="http://github.com/brendan/entrails"
end

require 'entrails/action_controller'
require 'entrails/active_record'

if defined?(ActionController)
  ActionController::Routing::RouteSet.send(:include, Entrails::ActionController::NamedRouteParameter)
  ActionController::Base.send(:include, Entrails::ActionController::TemplateForReferer)
end

if defined?(ActiveRecord)
  ActiveRecord::Base.extend Entrails::ActiveRecord::BetterConditions
  ActiveRecord::Base.extend Entrails::ActiveRecord::FindByAssociation
end
