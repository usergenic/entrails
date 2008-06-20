#!/usr/bin/env ruby
$LOAD_PATH << File.join(File.dirname(__FILE__), 'lib')
require 'rubygems'
require './lib/entrails.rb'
require 'rake'
require 'spec/rake/spectask'

desc "Generates the gemspec, Manifest.txt and builds the gem."
task :gem => ["gem:gemspec","gem:manifest"]

namespace :gem do
  desc "Generates the entrails.gemspec file"
  task :gemspec do
    gemspec_code = <<-gemspec
      Gem::Specification.new do |s|
        s.name = %q{entrails}
        s.version = #{Entrails::VERSION.inspect}

        s.specification_version = 2 if s.respond_to? :specification_version=

        s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
        s.authors = #{Entrails::AUTHORS.inspect}
        s.date = #{Time.now.strftime('%Y-%m-%d').inspect}
        s.default_executable = %q{entrails}
        s.description = #{Entrails::DESCRIPTION.inspect}
        s.email = #{Entrails::EMAIL.inspect}
        s.executables = ["entrails"]
        s.extra_rdoc_files = ["History.txt", "Manifest.txt", "README.txt"]
        s.files = #{Entrails::MANIFEST.inspect}
        s.has_rdoc = true
        s.homepage = #{Entrails::HOMEPAGE.inspect}
        s.rdoc_options = ["--main", "README.txt"]
        s.require_paths = ["lib"]
        s.rubygems_version = %q{1.1.1}
        s.summary = #{Entrails::DESCRIPTION.inspect}
      end
    gemspec
    gemspec = File.open(File.join(File.dirname(__FILE__),'entrails.gemspec'),'w')
    gemspec.write(gemspec_code)
    gemspec.close
  end
  desc "Generates the Manifest.txt file"
  task :manifest do
    manifest = File.open(File.join(File.dirname(__FILE__),'Manifest.txt'),'w')
    manifest.write(Entrails::MANIFEST.join("\n")<<"\n")
    manifest.close
  end
end

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