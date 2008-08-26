      Gem::Specification.new do |s|
        s.name = %q{entrails}
        s.version = "1.0.3"

        s.specification_version = 2 if s.respond_to? :specification_version=

        s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
        s.authors = ["Brendan Baldwin"]
        s.date = "2008-08-26"
        s.default_executable = %q{entrails}
        s.description = "This is a collection of extensions to Rails internals that I've found to be absolutely indispensible since I implimented them.  The real action is happening in the following two files at the moment: http://github.com/brendan/entrails/tree/master/lib/entrails/active_record/better_conditions.rb http://github.com/brendan/entrails/tree/master/lib/entrails/active_record/find_by_association.rb"
        s.email = ["brendan@usergenic.com"]
        s.executables = ["entrails"]
        s.extra_rdoc_files = ["History.txt", "Manifest.txt", "README.txt"]
        s.files = ["bin", "bin/entrails", "entrails.gemspec", "History.txt", "init.rb", "lib", "lib/entrails", "lib/entrails/action_controller", "lib/entrails/action_controller/named_route_parameter.rb", "lib/entrails/action_controller/template_for_referer.rb", "lib/entrails/action_controller.rb", "lib/entrails/active_record", "lib/entrails/active_record/better_conditions.rb", "lib/entrails/active_record/find_by_association.rb", "lib/entrails/active_record.rb", "lib/entrails.rb", "Manifest.txt", "Rakefile", "README.txt", "spec", "spec/entrails", "spec/entrails/active_record", "spec/entrails/active_record/better_conditions_spec.rb", "spec/entrails/active_record/find_by_association_spec.rb", "spec/spec_helper.rb"]
        s.has_rdoc = true
        s.homepage = "http://github.com/brendan/entrails"
        s.rdoc_options = ["--main", "README.txt"]
        s.require_paths = ["lib"]
        s.rubygems_version = %q{1.1.1}
        s.summary = "This is a collection of extensions to Rails internals that I've found to be absolutely indispensible since I implimented them.  The real action is happening in the following two files at the moment: http://github.com/brendan/entrails/tree/master/lib/entrails/active_record/better_conditions.rb http://github.com/brendan/entrails/tree/master/lib/entrails/active_record/find_by_association.rb"
      end
