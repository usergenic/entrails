ENV['LOG_NAME'] = 'spec'

$LOAD_PATH << File.join(File.dirname(__FILE__), '..', 'lib')

begin
  require 'spec'
  require 'activesupport'
rescue LoadError
  require 'rubygems'
  require 'spec'
  require 'activesupport'
end

require 'entrails'
