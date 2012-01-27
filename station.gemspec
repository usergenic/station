Gem::Specification.new do |s|
  s.name          = "station"
  s.version       = '0.0.1'
  s.authors       = ["Brendan Baldwin"]
  s.email         = ["brendan@usergenic.com"]
  s.homepage      = "http://brendanbaldwin.com/station/"
  s.summary       = "You use it to generate files and folder structures."
  s.description   = "No, really.  You use it to generate files and folder structures."
  s.files         = `git ls-files`.split("\n")
  s.executables   = s.files.grep(/^bin\//).map{ |f| File.basename(f) }
  s.require_paths = ['lib']

  s.add_development_dependency 'growl'
  s.add_development_dependency 'guard'
  s.add_development_dependency 'guard-rspec'
  s.add_development_dependency 'mocha'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec'
end
