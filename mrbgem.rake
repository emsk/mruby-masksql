require_relative 'mrblib/mruby-masksql/version'

MRuby::Gem::Specification.new('mruby-masksql') do |spec|
  spec.license = 'MIT'
  spec.author  = 'emsk'
  spec.version = MrubyMasksql::VERSION
  spec.summary = 'An mruby implementation of the MaskSQL'
  spec.bins    = ['mruby-masksql']

  spec.add_dependency 'mruby-array-ext',  :core => 'mruby-array-ext'
  spec.add_dependency 'mruby-enumerator', :core => 'mruby-enumerator'
  spec.add_dependency 'mruby-print',      :core => 'mruby-print'
  spec.add_dependency 'mruby-string-ext', :core => 'mruby-string-ext'
  spec.add_dependency 'mruby-io'
  spec.add_dependency 'mruby-mtest'
  spec.add_dependency 'mruby-onig-regexp'
  spec.add_dependency 'mruby-optparse'
  spec.add_dependency 'mruby-yaml'
end
