module Entrails
  VERSION='1.0.1'
  AUTHORS=["Brendan Baldwin"]
  EMAIL=["brendan@usergenic.com"]
  DESCRIPTION=%q{This is a collection of extensions to Rails internals that I've found to be absolutely indispensible since I implimented them.  The real action is happening in the following two files at the moment: http://github.com/brendan/entrails/tree/master/lib/entrails/active_record/better_conditions.rb http://github.com/brendan/entrails/tree/master/lib/entrails/active_record/find_by_association.rb= entrails}
  FOLDER=File.expand_path(File.join(File.dirname(__FILE__),'..'))
  MANIFEST=Dir.glob(File.join(FOLDER,'**','*')).map{|path|path[FOLDER.size+1..-1]}
  HOMEPAGE="http://github.com/brendan/entrails"
  class << self
    def activate
      ActiveRecord::Base.extend Entrails::ActiveRecord::BetterConditions
      ActiveRecord::Base.extend Entrails::ActiveRecord::FindByAssociation
    end
  end
end

require 'entrails/active_record'
