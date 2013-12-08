Gem::Specification.new do |s|
  s.name        = 'rushi'
  s.version     = '0.0.1'
  s.date        = '2013-12-05'
  s.summary     = "Convert javascript JSON data into a Ruby OpenStruct"
  s.description = "Convert javascript JSON data into a Ruby OpenStruct with ruby naming convention"
  s.authors     = ["Harry Gao"]
  s.email       = 'foxgaocn@gmail.com'
  s.files       = [".gitignore", "LICENSE", "rushi.gemspec", "README.md","lib/rushi.rb", "lib/rushi/rushi_object.rb"]
  s.homepage    =
    'http://rubygems.org/gems/rushi'
  s.license     = 'MIT'
  s.test_files  = ["spec/rushi_object_spec.rb", "spec/spec_helper.rb"]

  s.add_development_dependency "bundler", "~> 1.3"
  s.add_development_dependency "rake"
  s.add_development_dependency "rspec"
end