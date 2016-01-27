describe Envm::Manifest do
  subject { Envm::Manifest.new }

  before do
    Envm::Config.manifest_path = File.join(File.expand_path(__dir__), "..", "fixtures", "env.yml")
  end

  describe '#required_vars' do
    context 'when environment is not specified' do
      it 'returns all globally required variables' do
        expected_values = ['AWS_ACCESS_KEY_ID', 'AWS_SECRET_ACCESS_KEY', 'REQUIRED_WITH_DEFAULT']
        expect(subject.required_vars).to eq(expected_values)
      end
    end

    context 'when environment is set' do
      let(:env) { 'production' }

      before do
        Envm::Config.environment = env
      end

      it 'returns only required env vars for that environment' do
        expected_values = [
          'AWS_ACCESS_KEY_ID',
          'AWS_SECRET_ACCESS_KEY',
          'REQUIRED_WITH_DEFAULT',
          'REQUIRED_ON_PROD',
          'REQUIRED_WITH_DEFAULT_ON_PROD',
        ]

        expect(subject.required_vars).to eq(expected_values)
      end
    end
  end
end
