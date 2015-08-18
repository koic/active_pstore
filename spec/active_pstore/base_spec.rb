describe ActivePStore::Base do
  class ArtistWithoutInitializeMethod < ActivePStore::Base
    attr_accessor :name, :associated_act, :instrument, :birth_date
  end

  include_context 'Rock stars on stage'

  let(:attributes) {
    {
      name: 'Edward Van Halen',
      associated_act: 'Van Halen',
      instrument: 'guitar',
      birth_date: Date.new(1955, 1, 26)
    }
  }

  let(:block) {
    ->(a) {
      a.name = 'Edward Van Halen'
      a.associated_act = 'Van Halen'
      a.instrument = 'guitar'
      a.birth_date = Date.new(1955, 1, 26)
    }
  }

  shared_examples_for 'instantiate ActivePStore model' do
    it { expect(subject.name).to eq 'Edward Van Halen' }
    it { expect(subject.associated_act).to eq 'Van Halen' }
    it { expect(subject.instrument).to eq 'guitar' }
    it { expect(subject.birth_date).to eq Date.new(1955, 1, 26) }
  end

  describe '.new' do
    context 'with attributes' do
      subject { ArtistWithoutInitializeMethod.new(attributes) }

      it_behaves_like 'instantiate ActivePStore model'

      it { is_expected.to be_new_record }
    end

    context 'with block' do
      subject { ArtistWithoutInitializeMethod.new(&block) }

      it_behaves_like 'instantiate ActivePStore model'

      it { is_expected.to be_new_record }
    end
  end

  describe '.build' do
    context 'with attributes' do
      subject { ArtistWithoutInitializeMethod.build(attributes) }

      it_behaves_like 'instantiate ActivePStore model'

      it { is_expected.to be_new_record }
    end

    context 'with block' do
      subject { ArtistWithoutInitializeMethod.build(&block) }

      it_behaves_like 'instantiate ActivePStore model'

      it { is_expected.to be_new_record }
    end
  end

  describe '.create' do
    subject { ArtistWithoutInitializeMethod.create(attributes) }

    it_behaves_like 'instantiate ActivePStore model'

    it { is_expected.not_to be_new_record }

    specify { subject.should eq(ArtistWithoutInitializeMethod.find(subject)) }
  end
end
