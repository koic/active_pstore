describe ActivePStore::Inheritance do
  include_context 'Rock stars on stage'

  describe 'ActivePStore::Base.new' do
    let(:error_message) { 'ActivePStore::Base is an abstract class and cannot be instantiated.' }

    subject { ActivePStore::Base.new }

    it { expect { subject }.to raise_error(NotImplementedError, error_message) }
  end
end
