describe Envm::Config do
  subject { described_class.new }

  describe '#environment' do
    context 'not set' do
      before do
        subject.environment = nil
      end

      it 'returns RAILS_ENV value' do
        ENV['RAILS_ENV'] = 'development'
        expect(subject.environment).to eq('development')
      end

      context 'when RAILS_ENV not set' do
        before do
         ENV['RAILS_ENV'] = nil
        end

        it 'returns RACK_ENV value' do
          ENV['RACK_ENV'] = 'staging'
          expect(subject.environment).to eq('staging')
        end
      end
    end
  end

  describe '#secret_environment?' do
    context 'current environment is one of the secret environments' do
      before do
        subject.environment = 'dev'
      end

      it 'returns false' do
        expect(subject).to_not be_secret_environment
      end
    end

    context 'current environment is one of the secret environments' do
      before do
        subject.environment = 'production'
      end

      it 'returns true' do
        expect(subject).to be_secret_environment
      end
    end
  end
end
