# -*- frozen-string-literal: true -*-

describe ActivePStore::Persistence do
  include_context 'Rock stars on stage'

  describe '#new_record?' do
    let(:edward_van_halen)  {
      Artist.new(
        name: 'Edward Van Halen',
        associated_act: 'Van Halen',
        instrument: 'guitar',
        birth_date: Date.new(1955, 1, 26)
      )
    }

    subject { edward_van_halen.new_record? }

    context 'new record' do
      it { is_expected.to be true }
    end

    context 'exists record' do
      before do
        edward_van_halen.save
      end

      it { is_expected.to be false }
    end
  end

  describe '#persisted?' do
    let(:edward_van_halen)  {
      Artist.new(
        name: 'Edward Van Halen',
        associated_act: 'Van Halen',
        instrument: 'guitar',
        birth_date: Date.new(1955, 1, 26)
      )
    }

    subject { edward_van_halen.persisted? }

    context 'new record' do
      it { is_expected.to be false }
    end

    context 'exists record' do
      before do
        edward_van_halen.save
      end

      it { is_expected.to be true }
    end
  end

  describe '#destroy' do
    describe 'return value' do
      subject { randy_rhoads.destroy }

      it { is_expected.to eq(randy_rhoads) }
    end

    context 'destroyed data' do
      before { randy_rhoads.destroy }

      it { expect { Artist.find(randy_rhoads) }.to raise_error(ActivePStore::RecordNotFound, "Couldn't find Artist with 'id'=#{randy_rhoads.id}") }
      specify { expect(Artist.count).to eq(3) }
    end
  end

  describe '#save' do
    before do
      Artist.destroy_all
    end

    let(:edward_van_halen) {
      Artist.new(
        name: 'Edward Van Halen',
        associated_act: 'Van Halen',
        instrument: 'guitar',
        birth_date: Date.new(1955, 1, 26)
      )
    }

    describe 'return value' do
      subject { edward_van_halen.save }

      it { expect(subject).to be true }
    end

    context 'save for the one time' do
      before do
        edward_van_halen.save
      end

      specify { expect(Artist.count).to eq(1) }
    end

    context 'save for the second time' do
      before do
        edward_van_halen.save
        edward_van_halen.save
      end

      specify { expect(Artist.count).to eq(1) }
    end

    context 'update' do
      before do
        edward_van_halen.save

        edward_van_halen.name = 'Eddie Van Halen'

        edward_van_halen.save
      end

      specify { expect(Artist.find(edward_van_halen).name).to eq('Eddie Van Halen') }
    end
  end

  describe '#update_attribute' do
    subject { randy_rhoads.update_attribute(:associated_act, 'The Super Band') }

    it { is_expected.to be true }

    shared_examples_for 'updated data' do
      it {
        expect { subject }.to change(randy_rhoads, :associated_act).from('Ozzy Osbourne').to('The Super Band')
      }
      it {
        expect { subject }.to_not change(zakk_wylde, :associated_act).from('Ozzy Osbourne')
      }
    end

    it_behaves_like 'updated data' do
      let(:attr_name) { :associated_act }
    end

    it_behaves_like 'updated data' do
      let(:attr_name) { 'associated_act' }
    end
  end

  %w(update update_attributes).each do |method_name|
    describe "##{method_name}" do
      subject { randy_rhoads.public_send(method_name, associated_act: 'The Super Band', instrument: 'vocal') }

      it { is_expected.to be true }
      it {
        expect { subject }.to change(randy_rhoads, :associated_act).from('Ozzy Osbourne').to('The Super Band')
      }
      it {
        expect { subject }.to change(randy_rhoads, :instrument).from('guitar').to('vocal')
      }
      it {
        expect { subject }.to_not change(zakk_wylde, :associated_act).from('Ozzy Osbourne')
      }
    end
  end

  describe 'default attribute' do
    describe 'id' do
      let(:edward_van_halen) {
        Artist.new(
          name: 'Edward Van Halen',
          associated_act: 'Van Halen',
          instrument: 'guitar',
          birth_date: Date.new(1955, 1, 26)
        )
      }

      subject { edward_van_halen.id }

      context 'before save' do
        it { is_expected.to be_nil }
      end

      context 'after save' do
        before do
          edward_van_halen.save
        end

        it { is_expected.to be_a(String) }
        it { expect(subject.size).to eq(32) }
      end

      context 'save for the second time' do
        let!(:id) { randy_rhoads.id }

        before do
          randy_rhoads.save
        end

        it { expect(randy_rhoads.id).to eq(id) }
      end
    end
  end
end
