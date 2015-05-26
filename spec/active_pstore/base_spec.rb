require 'spec_helper'
require 'active_pstore'

describe ActivePStore::Base do
  class Artist < ActivePStore::Base
    def initialize(name, associated_act, instrument)
      @name = name
      @associated_act = associated_act
      @instrument = instrument
    end

    attr_reader :name, :associated_act, :instrument
  end

  let(:key)           { Artist.key }
  let(:randy_rhoads)  { Artist.new('Randy Rhoads', 'Ozzy Osbourne', 'guitar') }
  let(:michael_amott) { Artist.new('Michael Amott', 'Arch Enemy', 'guitar') }
  let(:don_airey)     { Artist.new('Don Airey', 'Ozzy Osbourne', 'keyboard') }
  let(:zakk_wylde)    { Artist.new('Zakk Wylde', 'Ozzy Osbourne', 'guitar') }

  before do
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
end
