Gem::Specification.new do |s|
  s.name          = "Station"
  s.version       = '1.0.0'
  s.authors       = ["Brendan Baldwin"]
  s.email         = ["brendan@usergenic.com"]
  s.homepage      = ["brendanbaldwin.com/station/"]
  s.summary       = "You use it to generate files and folder structures."
  s.description   = "No, really.  You use it to generate files and folder structures."
  s.files         = `git ls-files`.split("\n")
  s.executables   = s.files.grep(/^bin\//).map{ |f| File.basename(f) }
  s.require_paths = ['lib']

  s.add_development_dependency 'guard'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec'
end
