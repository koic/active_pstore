require 'spec_helper'
require 'active_pstore'

describe ActivePStore::Base do
  class Guitarist < ActivePStore::Base
    def initialize(name)
      @name = name
    end

    attr_reader :name
  end

  let(:key)          { Guitarist.key }
  let(:randy_rhoads) { Guitarist.new('Randy Rhoads') }
  let(:zakk_wylde)   { Guitarist.new('Zakk Wylde') }

  describe '.first' do
    before do
      Guitarist.destroy_all
    end

    subject { Guitarist.first }

    context 'exists data' do
      before do
        randy_rhoads.save
        zakk_wylde.save
      end

      it { expect(subject).to be_an(Guitarist) }
      it { expect(subject.name).to eq('Randy Rhoads') }
    end

    context 'empty data' do
      it { expect(subject).to be_nil }
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
        zakk_wylde.save
      end

      it { expect(subject).to eq(2) }
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
