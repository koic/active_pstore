require 'spec_helper'
require 'active_pstore'

describe ActivePStore::Base do
  class Artist < ActivePStore::Base
    def initialize(name, associated_act, instrument, birth_date)
      @name = name
      @associated_act = associated_act
      @instrument = instrument
      @birth_date = birth_date
    end

    attr_accessor :name, :associated_act, :instrument, :birth_date
  end

  let(:key)           { Artist.key }
  let(:randy_rhoads)  { Artist.new('Randy Rhoads', 'Ozzy Osbourne', 'guitar', Date.new(1956, 12, 6)) }
  let(:michael_amott) { Artist.new('Michael Amott', 'Arch Enemy', 'guitar', Date.new(1969, 7, 28)) }
  let(:don_airey)     { Artist.new('Don Airey', 'Ozzy Osbourne', 'keyboard', Date.new(1948, 6, 21)) }
  let(:zakk_wylde)    { Artist.new('Zakk Wylde', 'Ozzy Osbourne', 'guitar', Date.new(1948, 12, 3)) }

  before do
    Artist.establish_connection(database: '/tmp/active_pstore_test')

    Artist.destroy_all

    randy_rhoads.save
    michael_amott.save
    don_airey.save
    zakk_wylde.save
  end

  describe '.first' do
    subject { Artist.first }

    context 'exists data' do
      it { is_expected.to be_an(Artist) }
      it { expect(subject.name).to eq('Randy Rhoads') }
    end

    context 'empty data' do
      before do
        Artist.destroy_all
      end

      it { is_expected.to be_nil }
    end
  end

  describe '.last' do
    subject { Artist.last }

    context 'exists data' do
      it { is_expected.to be_an(Artist) }
      it { expect(subject.name).to eq('Zakk Wylde') }
    end

    context 'empty data' do
      before do
        Artist.destroy_all
      end

      it { is_expected.to be_nil }
    end
  end

  describe '.find' do
    subject { Artist.find(id) }

    shared_examples_for 'fishing with a pole' do
      context 'exists data' do
        it { is_expected.to be_an(Artist) }
        it { expect(subject.name).to eq('Randy Rhoads') }
      end

      context 'not found' do
        let(:id) { '9' * 32 }

        before do
          Artist.destroy_all
        end

        it { expect { subject }.to raise_error(ActivePStore::RecordNotFound, "Couldn't find Artist with 'id'=#{id}") }
      end
    end

    it_behaves_like 'fishing with a pole' do
      let(:id) { randy_rhoads.id }
    end

    it_behaves_like 'fishing with a pole' do
      let(:id) { randy_rhoads }
    end
  end

  describe '.find_by' do
    subject { Artist.find_by(conditions) }

    context 'exists data' do
      context 'have 1 condition' do
        let(:conditions) { {associated_act: 'Ozzy Osbourne'} }

        it { is_expected.to be_an(Artist) }
        it { expect(subject.name).to eq('Randy Rhoads') }
      end

      context 'have 2 conditions' do
        let(:conditions) { {associated_act: 'Ozzy Osbourne', instrument: 'guitar'} }

        it { is_expected.to be_an(Artist) }
        it { expect(subject.name).to eq('Randy Rhoads') }
      end

      context 'date between' do
        let(:conditions) { {birth_date: Date.new(1948, 12, 3)..Date.new(1956, 12, 6)} }

        it { is_expected.to be_an(Artist) }
        it { expect(subject.name).to eq('Randy Rhoads') }
      end
    end

    context 'not found' do
      let(:conditions) { {} }

      before do
        Artist.destroy_all
      end

      it { is_expected.to be_nil }
    end
  end

  describe '.where' do
    subject { Artist.where(conditions) }

    context 'exists data' do
      context 'have 1 condition' do
        let(:conditions) { {associated_act: 'Ozzy Osbourne'} }

        it { is_expected.to be_an(Array) }
        it { expect(subject.size).to eq(3) }
        it { expect(subject[0].name).to eq('Randy Rhoads') }
        it { expect(subject[1].name).to eq('Don Airey') }
        it { expect(subject[2].name).to eq('Zakk Wylde') }
      end

      context 'have 2 conditions' do
        let(:conditions) { {associated_act: 'Ozzy Osbourne', instrument: 'guitar'} }

        it { is_expected.to be_an(Array) }
        it { expect(subject.size).to eq(2) }
        it { expect(subject[0].name).to eq('Randy Rhoads') }
        it { expect(subject[1].name).to eq('Zakk Wylde') }
      end

      context 'date between' do
        let(:conditions) { {birth_date: Date.new(1948, 12, 3)..Date.new(1956, 12, 6)} }

        it { is_expected.to be_an(Array) }
        it { expect(subject.size).to eq(2) }
        it { expect(subject[0].name).to eq('Randy Rhoads') }
        it { expect(subject[1].name).to eq('Zakk Wylde') }
      end
    end

    context 'not found' do
      let(:conditions) { {} }

      before do
        Artist.destroy_all
      end

      it { is_expected.to be_empty }
    end
  end

  describe '.count' do
    subject { Artist.count }

    context 'exists data' do
      it { is_expected.to eq(4) }
    end

    context 'empty data' do
      before do
        Artist.destroy_all
      end

      it { is_expected.to be_zero }
    end
  end

  describe '.destroy_all' do
    before do
      Artist.destroy_all
    end

    subject { Artist.all }

    it { is_expected.to be_an(Array) }
    it { is_expected.to be_empty }
  end

  describe '#update_attribute' do
    describe 'return value' do
      subject { randy_rhoads.update_attribute(:associated_act, 'The Super Band') }

      it { is_expected.to be true }
    end

    shared_examples_for 'updated data' do
      subject { randy_rhoads.update_attribute(attr_name, 'The Super Band') }

      it {
        expect { subject }.to change(randy_rhoads, :associated_act).from('Ozzy Osbourne').to('The Super Band')
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

  describe '#update_attributes' do
    subject { randy_rhoads.update_attributes(associated_act: 'The Super Band', instrument: 'vocal') }

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

    let(:edward_van_halen)  { Artist.new('Edward Van Halen', 'Van Halen', 'guitar', Date.new(1955, 1, 26)) }

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

  describe '#new_record?' do
    let(:edward_van_halen)  { Artist.new('Edward Van Halen', 'Van Halen', 'guitar', Date.new(1955, 1, 26)) }

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

  describe 'default attribute' do
    describe 'id' do
      let(:edward_van_halen)  { Artist.new('Edward Van Halen', 'Van Halen', 'guitar', Date.new(1955, 1, 26)) }

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
