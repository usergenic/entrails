module Entrails::ActiveRecord
end

require 'entrails/active_record/better_conditions'
require 'entrails/active_record/find_by_association'

ActiveRecord::Base.extend Entrails::ActiveRecord::BetterConditions
ActiveRecord::Base.extend Entrails::ActiveRecord::FindByAssociation
