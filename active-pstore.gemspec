# encoding: utf-8

$:.push File.expand_path('../lib', __FILE__)

require 'active_pstore/version'

Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name = 'active-pstore'
  s.summary = 'This library has ActiveRecord like interface. Use pstore to store data.'
  s.description = 'This library has ActiveRecord like interface. Use pstore to store data.'
  s.date = '2015-05-30'

  s.version = ActivePStore::VERSION

  s.license = 'MIT'

  s.authors = ['Koichi ITO']
  s.email = 'koic.ito@gmail.com'
  s.homepage = 'http://github.com/koic/active-pstore'

  s.files = Dir[
    'README.md',
    'README.ja.md',
    'lib/**/*',
    'LICENSE'
  ]
  s.require_paths = ['lib']
  s.executables = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }

  s.required_ruby_version = '>= 2.0.0'
  s.license = 'MIT'

  s.add_development_dependency('rspec')
end
