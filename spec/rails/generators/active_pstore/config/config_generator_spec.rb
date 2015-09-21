require 'rails/generators/active_pstore/config/config_generator'

describe ActivePstore::Generators::ConfigGenerator, type: :generator do
  destination File.expand_path('../../../../../../tmp', __FILE__)

  let(:config_file) { File.read('lib/rails/generators/active_pstore/config/templates/active_pstore.yml') }

  before(:all) do
    prepare_destination
    run_generator
  end

  it 'creates a active_pstore config' do
    assert_file 'config/active_pstore.yml', config_file
  end
end
