begin
  require File.join(File.dirname(__FILE__), 'lib', 'entrails') # From here
rescue LoadError
  require 'entrails' # From gem
end
