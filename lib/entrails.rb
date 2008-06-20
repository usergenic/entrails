module Entrails
  VERSION='1.0.1'
  class << self
    def activate
      ActiveRecord::Base.extend Entrails::ActiveRecord::BetterConditions
      ActiveRecord::Base.extend Entrails::ActiveRecord::FindByAssociation
    end
  end
end

require 'entrails/active_record'
