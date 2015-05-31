require 'spec_helper'

describe ActivePStore::ConnectionHandling do
  include_context 'Rock stars on stage'

  describe 'ActivePStore::Base.new' do
    subject { ActivePStore::Base.new }

    it {
      expect { subject }.to raise_error(NotImplementedError, 'ActivePStore::Base is an abstract class and cannot be instantiated.')
    }
  end
end
