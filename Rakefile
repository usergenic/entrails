#!/usr/bin/env ruby
$LOAD_PATH << File.join(File.dirname(__FILE__), 'lib')
require 'rubygems'
require 'hoe'
require './lib/entrails.rb'
require 'rake'
require 'spec/rake/spectask'

Hoe.new('entrails', Entrails::VERSION) do |p|
  p.developer('Brendan Baldwin', 'brendan@usergenic.com')
end

# vim: syntax=Ruby

desc "Run all specs"
Spec::Rake::SpecTask.new do |t|
  t.spec_files = FileList['spec/**/*_spec.rb']
end

namespace :spec do
  desc "Run all specs and stake out all files/folders for changes, running rake spec upon change"
  task :auto => 'spec' do

    # This task assumes you are running on a Mac, with growl installed.  Perhaps
    # there will be a better way to abstract this, but it works for us now.
    def growl(title, msg, img, pri=0, sticky="")
      system "growlnotify -n autotest --image ~/.autotest_images/#{img} -p #{pri} -m #{msg.inspect} #{title} #{sticky}"
    end
    def self.growl_fail(output)
      growl "FAIL", "#{output}", "fail.png", 2
    end
    def self.growl_pass(output)
      growl "Pass", "#{output}", "pass.png"
    end

    command = 'rake spec'
    files = {}

    def files.reglob
      Dir['**/*.rb'].each {|file| self[file] ||= File.mtime(file)}
    end

    files.reglob

    puts "Watching #{files.keys.join(', ')}\n\nFiles: #{files.keys.length}"

    trap('INT') do
      puts "\nQuitting..."
      exit
    end

    loop do

      sleep 3

      files.reglob

      changed_file, last_changed = files.find do |file, last_changed|
        begin
          File.mtime(file) > last_changed
        rescue
          files.delete(file)
        end
      end

      if changed_file
        files[changed_file] = File.mtime(changed_file)
        puts "=> #{changed_file} changed, running #{command}"
        results = `#{command}`
        puts results

        if results.include? 'tests'
          output = results.slice(/(\d+)\s+tests?,\s*(\d+)\s+assertions?,\s*(\d+)\s+failures?(,\s*(\d+)\s+errors)?/)
          if output
            $~[3].to_i + $~[5].to_i > 0 ? growl_fail(output) : growl_pass(output)
          end
        else
          output = results.slice(/(\d+)\s+examples?,\s*(\d+)\s+failures?(,\s*(\d+)\s+not implemented)?/)
          if output
            $~[2].to_i > 0 ? growl_fail(output) : growl_pass(output)
          end
        end
        # TODO Generic growl notification for other actions

        puts "=> done"
      end

    end
     
  end
end