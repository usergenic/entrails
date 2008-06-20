Gem::Specification.new do |s|
  s.name = %q{entrails}
  s.version = "1.0.1"

  s.specification_version = 2 if s.respond_to? :specification_version=

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Brendan Baldwin"]
  s.date = %q{2008-06-20}
  s.default_executable = %q{entrails}
  s.description = %q{This is a collection of extensions to Rails internals that I've found to be absolutely indispensible since I implimented them.  The real action is happening in the following two files at the moment: http://github.com/brendan/entrails/tree/master/lib/entrails/active_record/better_conditions.rb http://github.com/brendan/entrails/tree/master/lib/entrails/active_record/find_by_association.rb= entrails}
  s.email = ["brendan@usergenic.com"]
  s.executables = ["entrails"]
  s.extra_rdoc_files = ["History.txt", "Manifest.txt", "README.txt"]
  s.files = %w{
    History.txt
    Manifest.txt
    README.txt
    Rakefile
    bin/entrails
    lib/entrails.rb
    lib/entrails/active_record.rb
    lib/entrails/active_record/better_conditions.rb
    lib/entrails/active_record/find_by_association.rb
    spec/entrails/active_record/better_conditions_spec.rb
    spec/entrails/active_record/find_by_association_spec.rb
    spec/spec_helper.rb
  }
  s.has_rdoc = true
  s.homepage = %q{http://github.com/brendan/entrails}
  s.rdoc_options = ["--main", "README.txt"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.1.1}
  s.summary = %q{This is a collection of extensions to Rails internals that I've found to be absolutely indispensible since I implimented them}
end
