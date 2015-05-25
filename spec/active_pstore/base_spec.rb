require 'spec_helper'
require 'active_pstore'

describe ActivePStore::Base do
  class Guitarist < ActivePStore::Base
    def initialize(name, associated_act)
      @name = name
      @associated_act = associated_act
    end

    attr_reader :name, :associated_act
  end

  let(:key)           { Guitarist.key }
  let(:randy_rhoads)  { Guitarist.new('Randy Rhoads', 'Ozzy Osbourne') }
  let(:michael_amott) { Guitarist.new('Michael Amott', 'Arch Enemy') }
  let(:zakk_wylde)    { Guitarist.new('Zakk Wylde', 'Ozzy Osbourne') }

  describe '.first' do
    before do
      Guitarist.destroy_all
    end

    subject { Guitarist.first }

    context 'exists data' do
      before do
        randy_rhoads.save
        michael_amott.save
        zakk_wylde.save
      end

      it { expect(subject).to be_an(Guitarist) }
      it { expect(subject.name).to eq('Randy Rhoads') }
    end

    context 'empty data' do
      it { expect(subject).to be_nil }
    end
  end

  describe '.last' do
    before do
      Guitarist.destroy_all
    end

    subject { Guitarist.last }

    context 'exists data' do
      before do
        randy_rhoads.save
        michael_amott.save
        zakk_wylde.save
      end

      it { expect(subject).to be_an(Guitarist) }
      it { expect(subject.name).to eq('Zakk Wylde') }
    end

    context 'empty data' do
      it { expect(subject).to be_nil }
    end
  end

  describe '.where' do
    before do
      Guitarist.destroy_all
    end

    subject { Guitarist.where(associated_act: 'Ozzy Osbourne') }

    context 'exists data' do
      before do
        randy_rhoads.save
        michael_amott.save
        zakk_wylde.save
      end

      it { expect(subject).to be_an(Array) }
      it { expect(subject.size).to eq(2) }
      it { expect(subject[0].name).to eq('Randy Rhoads') }
      it { expect(subject[1].name).to eq('Zakk Wylde') }
    end

    context 'empty data' do
      it { expect(subject).to be_empty }
    end
  end

  describe '.count' do
    before do
      Guitarist.destroy_all
    end

    subject { Guitarist.count }

    context 'exists data' do
      before do
        randy_rhoads.save
        michael_amott.save
        zakk_wylde.save
      end

      it { expect(subject).to eq(3) }
    end

    context 'empty data' do
      it { expect(subject).to be_zero }
    end
  end

  describe '.destroy_all' do
    before do
      randy_rhoads.save

      Guitarist.destroy_all
    end

    subject { Guitarist.all }

    it { expect(subject).to be_an(Array) }
    it { expect(subject).to be_empty }
  end
end
