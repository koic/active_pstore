# -*- frozen-string-literal: true -*-

describe ActivePStore::AttributeMethods do
  include_context 'Rock stars on stage'

  describe '#[]' do
    subject { randy_rhoads[attr_name] }

    context 'fetch name' do
      let(:attr_name) { :name }

      it { is_expected.to eq randy_rhoads.name }
    end

    context 'fetch id' do
      let(:attr_name) { :id }

      it { is_expected.to eq randy_rhoads.id }
    end

    context 'undefined method' do
      let(:attr_name) { :undefined_method }

      it { expect { subject }.to raise_error(StandardError, "undefined method `undefined_method'") }
    end
  end

  describe '#[]=' do
    subject { randy_rhoads[attr_name] = 'RR' }

    context 'set name' do
      let(:attr_name) { :name }

      it { is_expected.to eq randy_rhoads.name }
    end

    context 'undefined method' do
      let(:attr_name) { :undefined_method }

      it { expect { subject }.to raise_error(StandardError, "undefined method `undefined_method='") }
    end
  end
end
