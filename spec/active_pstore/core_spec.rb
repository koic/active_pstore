require 'spec_helper'

describe ActivePStore::Core do
  include_context 'Rock stars on stage'

  describe '#==' do
    let(:let) { randy_rhoads }

    subject { Artist.find(randy_rhoads) }

    it { is_expected.to eq randy_rhoads }
  end
end
