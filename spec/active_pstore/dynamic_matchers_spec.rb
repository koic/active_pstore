describe ActivePStore::DynamicMatchers do
  include_context 'Rock stars on stage'

  describe ActivePStore::DynamicMatchers::FindBy do
    describe '.find_by_name' do
      let(:name) { 'Randy Rhoads' }

      subject { Artist.find_by_name(name) }

      context 'exist artist' do
        it { is_expected.to eq(randy_rhoads) }
        it { is_expected.not_to eq(zakk_wylde) }
      end

      context 'not found' do
        let(:name) { 'John Bonham' }

        it { is_expected.to be_nil }
      end
    end

    describe '.find_by_associated_act' do
      subject { Artist.find_by_associated_act(associated_act) }

      context 'exist artist' do
        let(:associated_act) { 'Ozzy Osbourne' }

        it { is_expected.to eq(randy_rhoads) }
        it { is_expected.not_to eq(zakk_wylde) }
      end

      context 'not found' do
        let(:associated_act) { 'Led Zeppelin' }

        it { is_expected.to be_nil }
      end
    end

    describe '.find_by_associated_act_and_instrument' do
      subject { Artist.find_by_associated_act_and_instrument(associated_act, instrument) }

      context 'exist Ozzy Osbourne band keyboardist' do
        let(:associated_act) { 'Ozzy Osbourne' }
        let(:instrument) { 'keyboard' }

        it { is_expected.to eq(don_airey) }
      end

      context 'exist Ozzy Osbourne guitarist' do
        let(:associated_act) { 'Ozzy Osbourne' }
        let(:instrument) { 'guitar' }

        it { is_expected.to eq(randy_rhoads) }
      end

      context 'not found' do
        let(:associated_act) { 'Led Zeppelin' }
        let(:instrument) { 'guitar' }

        it { is_expected.to be_nil }
      end
    end
  end

  describe ActivePStore::DynamicMatchers::FindByBang do
    describe '.find_by_name!' do
      subject { Artist.find_by_name!(name) }

      context 'exist artist' do
        let(:name) { 'Randy Rhoads' }

        it { is_expected.to eq(randy_rhoads) }
        it { is_expected.not_to eq(zakk_wylde) }
      end

      context 'not found' do
        let(:name) { 'John Bonham' }

        it { expect { subject }.to raise_error(ActivePStore::RecordNotFound, "Couldn't find Artist with conditions={:name=>\"John Bonham\"}") }
      end
    end

    describe '.find_by_associated_act!' do
      subject { Artist.find_by_associated_act!(associated_act) }

      context 'exist artist' do
        let(:associated_act) { 'Ozzy Osbourne' }

        it { is_expected.to eq(randy_rhoads) }
        it { is_expected.not_to eq(zakk_wylde) }
      end

      context 'not found' do
        let(:associated_act) { 'Led Zeppelin' }

        it { expect { subject }.to raise_error(ActivePStore::RecordNotFound, "Couldn't find Artist with conditions={:associated_act=>\"Led Zeppelin\"}") }
      end
    end
  end
end
