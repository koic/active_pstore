describe ActivePstore::Generators::ConfigGenerator, type: :generator do
  destination File.expand_path('../../../../../../tmp', __FILE__)

  before(:all) do
    prepare_destination
    run_generator
  end

  it 'creates a active_pstore config' do
    assert_file 'config/active_pstore.yml', <<-EOS
#
#   Ensure the Active PStore gem is defined in your Gemfile
#   gem 'active_pstore'
#
default: &default

development:
  <<: *default
  database: db/active_pstore_development.yml

# Warning: The database defined as "test" will be erased and
# re-generated from your development database when you run "rake".
# Do not set this db to the same as development or production.
test:
  <<: *default
  database: db/active_pstore_test.yml

production:
  <<: *default
  database: db/active_pstore_production.yml
    EOS
  end
end
