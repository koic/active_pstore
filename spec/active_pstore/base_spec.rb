describe ActivePStore::Base do
  include_context 'Rock stars on stage'

  class ArtistWithoutInitializeMethod < ActivePStore::Base
    attr_accessor :name, :associated_act, :instrument, :birth_date
  end

  describe '.new' do
    subject {
      ArtistWithoutInitializeMethod.new(
        name: 'Edward Van Halen',
        associated_act: 'Van Halen',
        instrument: 'guitar',
        birth_date: Date.new(1955, 1, 26)
      )
    }

    it { expect(subject.name).to eq 'Edward Van Halen' }
    it { expect(subject.associated_act).to eq 'Van Halen' }
    it { expect(subject.instrument).to eq 'guitar' }
    it { expect(subject.birth_date).to eq Date.new(1955, 1, 26) }
  end
end
