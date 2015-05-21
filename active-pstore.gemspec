# encoding: utf-8
$:.push File.expand_path('../lib', __FILE__)

require 'active_pstore/version'

Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name = 'active-pstore'
  s.summary = 'Later...'
  s.description = 'Later...'
  s.date = '2015-05-16'

  s.version = ActivePStore::VERSION

  s.license = 'MIT'

  s.authors = ['ITO Koichi']
  s.email = 'koic.ito@gmail.com'
  s.homepage = 'http://github.com/koic/active-pstore'

  s.files = [
    'README.md',
    'lib/active_pstore.rb',
    'lib/active_pstore/version.rb',
    'active-pstore.gemspec',
    'LICENSE'
  ]
  s.require_paths = ['lib']
  s.executables = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }

  s.required_ruby_version = '>= 2.0.0'
  s.license = 'MIT'

  s.add_dependency 'activemodel'
  s.add_development_dependency('rspec')
end
