# -*- encoding: utf-8 -*-
require File.expand_path('../lib/hotels_pro/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Michał Szajbe"]
  gem.email         = ["michal.szajbe@gmail.com"]
  gem.description   = %q{HotelsPro API wrapper}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "hotels_pro"
  gem.require_paths = ["lib"]
  gem.version       = HotelsPro::VERSION

  gem.add_dependency "activesupport"
  gem.add_dependency "typhoeus"
  gem.add_dependency "virtus"
  gem.add_development_dependency "rspec"
  gem.add_development_dependency "ZenTest"
end
