# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "let_me_mass_assign_protected_attributes/version"

Gem::Specification.new do |s|
  s.name        = "let_me_mass_assign_protected_attributes"
  s.version     = LetMeMassAssignProtectedAttributes.version
  s.authors     = ["Tyler Rick"]
  s.email       = ["tyler@tylerrick.com"]
  s.homepage    = ""
  s.summary     = %q{Thank you, Active Record, for not letting me mass-assign protected attributes. But sometimes I want to anyway. This gem provides unprotected_update_attributes, unprotected_create, and related methods to ActiveRecord::Base.}
  s.description = s.summary

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
