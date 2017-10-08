# -*- encoding: utf-8 -*-
# stub: youtube-dl.rb 0.3.1.2016.09.11.1 ruby lib

Gem::Specification.new do |s|
  s.name = "youtube-dl.rb"
  s.version = "0.3.1.2016.09.11.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["sapslaj", "xNightMare"]
  s.date = "2016-09-12"
  s.description = "in the spirit of pygments.rb and MiniMagick, youtube-dl.rb is a command line wrapper for the python script youtube-dl"
  s.email = ["saps.laj@gmail.com"]
  s.homepage = "https://github.com/layer8x/youtube-dl.rb"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.5.1"
  s.summary = "youtube-dl wrapper for Ruby"

  s.installed_by_version = "2.5.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<cocaine>, [">= 0.5.4"])
      s.add_development_dependency(%q<bundler>, [">= 1.6"])
      s.add_development_dependency(%q<rake>, ["~> 10.0"])
      s.add_development_dependency(%q<minitest>, ["~> 5.8.1"])
      s.add_development_dependency(%q<purdytest>, [">= 0"])
      s.add_development_dependency(%q<codeclimate-test-reporter>, [">= 0"])
    else
      s.add_dependency(%q<cocaine>, [">= 0.5.4"])
      s.add_dependency(%q<bundler>, [">= 1.6"])
      s.add_dependency(%q<rake>, ["~> 10.0"])
      s.add_dependency(%q<minitest>, ["~> 5.8.1"])
      s.add_dependency(%q<purdytest>, [">= 0"])
      s.add_dependency(%q<codeclimate-test-reporter>, [">= 0"])
    end
  else
    s.add_dependency(%q<cocaine>, [">= 0.5.4"])
    s.add_dependency(%q<bundler>, [">= 1.6"])
    s.add_dependency(%q<rake>, ["~> 10.0"])
    s.add_dependency(%q<minitest>, ["~> 5.8.1"])
    s.add_dependency(%q<purdytest>, [">= 0"])
    s.add_dependency(%q<codeclimate-test-reporter>, [">= 0"])
  end
end
