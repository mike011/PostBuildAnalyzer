# -*- encoding: utf-8 -*-
# stub: simctl 1.6.6 ruby lib

Gem::Specification.new do |s|
  s.name = "simctl".freeze
  s.version = "1.6.6"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Johannes Plunien".freeze]
  s.date = "2019-09-13"
  s.description = "Ruby interface to xcrun simctl".freeze
  s.email = ["plu@pqpq.de".freeze]
  s.homepage = "https://github.com/plu/simctl".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.0.3".freeze
  s.summary = "Ruby interface to xcrun simctl".freeze

  s.installed_by_version = "3.0.3" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<coveralls>.freeze, [">= 0"])
      s.add_development_dependency(%q<rake>.freeze, [">= 0"])
      s.add_development_dependency(%q<rspec>.freeze, [">= 0"])
      s.add_development_dependency(%q<rubocop>.freeze, ["= 0.49.1"])
      s.add_runtime_dependency(%q<CFPropertyList>.freeze, [">= 0"])
      s.add_runtime_dependency(%q<naturally>.freeze, [">= 0"])
    else
      s.add_dependency(%q<coveralls>.freeze, [">= 0"])
      s.add_dependency(%q<rake>.freeze, [">= 0"])
      s.add_dependency(%q<rspec>.freeze, [">= 0"])
      s.add_dependency(%q<rubocop>.freeze, ["= 0.49.1"])
      s.add_dependency(%q<CFPropertyList>.freeze, [">= 0"])
      s.add_dependency(%q<naturally>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<coveralls>.freeze, [">= 0"])
    s.add_dependency(%q<rake>.freeze, [">= 0"])
    s.add_dependency(%q<rspec>.freeze, [">= 0"])
    s.add_dependency(%q<rubocop>.freeze, ["= 0.49.1"])
    s.add_dependency(%q<CFPropertyList>.freeze, [">= 0"])
    s.add_dependency(%q<naturally>.freeze, [">= 0"])
  end
end
