require 'spec_helper'

describe ActivePStore::Base do
  include_context 'Rock stars on stage'

  describe '.pstore_key' do
    context Artist do
      subject { Artist.pstore_key }

      it { is_expected.to eq('Artist') }
    end
  end
end
