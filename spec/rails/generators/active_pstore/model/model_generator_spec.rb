require 'rails/generators/active_pstore/model/model_generator'

describe ActivePstore::Generators::ModelGenerator, type: :generator do
  destination File.expand_path('../../../../../../tmp', __FILE__)
  arguments %w(artist name associated_act instrument birth_date)

  let(:generated_code) { <<-EOS
class Artist < ActivePStore::Base
  attr_accessor :name
  attr_accessor :associated_act
  attr_accessor :instrument
  attr_accessor :birth_date
end
    EOS
  }

  before(:all) do
    prepare_destination
    run_generator
  end

  it 'creates a active_pstore model' do
    assert_file 'app/models/artist.rb', generated_code
  end
end
