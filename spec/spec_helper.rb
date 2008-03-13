ENV['LOG_NAME'] = 'spec'

$LOAD_PATH << File.join(File.dirname(__FILE__), '..', 'lib')

begin
  require 'activerecord'
  require 'spec'
rescue LoadError
  require 'rubygems'
  require 'activerecord'
  require 'spec'
end

require 'entrails'

