# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "en_route/version"

Gem::Specification.new do |s|
  s.name        = 'en_route'
  s.version     = EnRoute::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ['Andrew WC Brown']
  s.email       = ['omen.king@gmail.com']
  s.homepage    = ""
  s.summary     = %q{A a small off-side langauge that compiles into the routes.rb file for Rails 3}
  s.description = %q{A a small off-side langauge that compiles into the routes.rb file for Rails 3} 

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
