# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "email_list/version"

Gem::Specification.new do |s|
  s.name        = "email_list"
  s.version     = EmailList::VERSION
  s.authors     = ["Michael Guterl"]
  s.email       = ["michael@diminishing.org"]
  s.homepage    = "http://github.com/recruitmilitary/email_list"
  s.summary     = %q{A gem for managing a list of email addresses stored in a string.}
  s.description = %q{A gem for managing a list of email addresses stored in a string.}

  s.rubyforge_project = "email_list"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency "rspec"
end
