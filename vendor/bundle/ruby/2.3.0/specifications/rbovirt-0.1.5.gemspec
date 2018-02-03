# -*- encoding: utf-8 -*-
# stub: rbovirt 0.1.5 ruby lib

Gem::Specification.new do |s|
  s.name = "rbovirt"
  s.version = "0.1.5"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Amos Benari"]
  s.date = "2018-01-02"
  s.description = "    A Ruby client for oVirt REST API\n"
  s.email = ["abenari@redhat.com"]
  s.extra_rdoc_files = ["README.rdoc", "CHANGES.rdoc"]
  s.files = ["CHANGES.rdoc", "README.rdoc"]
  s.homepage = "http://github.com/abenari/rbovirt"
  s.licenses = ["MIT"]
  s.rdoc_options = ["--title", "rbovirt", "--main", "README.rdoc", "--line-numbers", "--inline-source"]
  s.required_ruby_version = Gem::Requirement.new(">= 1.9.3")
  s.rubygems_version = "2.5.1"
  s.summary = "A Ruby client for oVirt REST API"

  s.installed_by_version = "2.5.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<nokogiri>, [">= 0"])
      s.add_runtime_dependency(%q<rest-client>, ["> 1.7.0"])
      s.add_development_dependency(%q<shoulda>, [">= 0"])
      s.add_development_dependency(%q<rspec-rails>, ["~> 2.6"])
      s.add_development_dependency(%q<rake>, [">= 0"])
    else
      s.add_dependency(%q<nokogiri>, [">= 0"])
      s.add_dependency(%q<rest-client>, ["> 1.7.0"])
      s.add_dependency(%q<shoulda>, [">= 0"])
      s.add_dependency(%q<rspec-rails>, ["~> 2.6"])
      s.add_dependency(%q<rake>, [">= 0"])
    end
  else
    s.add_dependency(%q<nokogiri>, [">= 0"])
    s.add_dependency(%q<rest-client>, ["> 1.7.0"])
    s.add_dependency(%q<shoulda>, [">= 0"])
    s.add_dependency(%q<rspec-rails>, ["~> 2.6"])
    s.add_dependency(%q<rake>, [">= 0"])
  end
end
