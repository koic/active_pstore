$:.push File.expand_path('../lib', __FILE__)

require 'active_pstore/version'

Gem::Specification.new do |s|
  s.platform = Gem::Platform::RUBY
  s.name = 'active_pstore'
  s.summary = 'This library has Active Record like interface. Use pstore to store data.'
  s.description = 'This library has Active Record like interface. Use pstore to store data.'

  s.version = ActivePStore::VERSION

  s.license = 'MIT'

  s.authors = ['Koichi ITO']
  s.email = 'koic.ito@gmail.com'
  s.homepage = 'http://github.com/koic/active_pstore'

  s.files = Dir[
    'README.md',
    'README.ja.md',
    'lib/**/*',
    'LICENSE'
  ]
  s.require_paths = ['lib']

  s.required_ruby_version = '>= 2.0.0'

  if Gem::Version.create(RUBY_VERSION) >= Gem::Version.create('2.2.2')
    s.add_dependency('activemodel', '>= 4.0.0')
  else
    s.add_dependency 'activemodel', '>= 4.0.0', '< 5.0.0'
  end
  s.add_development_dependency('codeclimate-test-reporter')
  s.add_development_dependency('generator_spec')
  s.add_development_dependency('railties')
  s.add_development_dependency('rspec', '>= 3.0.0')
end
