describe ActivePStore::Base do
  class ArtistWithoutInitializeMethod < ActivePStore::Base
    attr_accessor :name, :associated_act, :instrument, :birth_date
  end

  shared_examples_for 'instantiate ActivePStore model' do
    let(:attributes) {
      {
        name: 'Edward Van Halen',
        associated_act: 'Van Halen',
        instrument: 'guitar',
        birth_date: Date.new(1955, 1, 26)
      }
    }

    it { expect(subject.name).to eq 'Edward Van Halen' }
    it { expect(subject.associated_act).to eq 'Van Halen' }
    it { expect(subject.instrument).to eq 'guitar' }
    it { expect(subject.birth_date).to eq Date.new(1955, 1, 26) }

    it { is_expected.to be_new_record }
  end

  describe '.new' do
    subject { ArtistWithoutInitializeMethod.new(attributes) }

    it_behaves_like 'instantiate ActivePStore model'
  end

  describe '.build' do
    subject { ArtistWithoutInitializeMethod.build(attributes) }

    it_behaves_like 'instantiate ActivePStore model'
  end
end
