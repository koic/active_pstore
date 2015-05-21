require 'spec_helper'
require 'active_pstore'

describe ActivePStore::Base do
  class Guitarist < ActivePStore::Base
    def initialize(name)
      @name = name
    end

    attr_reader :name
  end

  let(:key)        { Guitarist.key }
  let(:name)       { 'Randy Rhoads' }
  let(:guitarist)  { Guitarist.new(name) }

  describe '.all' do
    before do
      Guitarist.destroy_all
    end

    subject { Guitarist.all }

    context 'exists data' do
      before do
        guitarist.save
      end

      it { expect(subject).to be_an(Array) }
      it { expect(subject.first).to be_an(Guitarist) }
      it { expect(subject.first.name).to eq(name) }
    end

    context 'empty data' do
      it { expect(subject).to be_empty }
    end
  end

  describe '.destroy_all' do
    before do
      guitarist.save

      Guitarist.destroy_all
    end

    subject { Guitarist.all }

    it { expect(subject).to be_an(Array) }
    it { expect(subject).to be_empty }
  end
end
