require 'envm'

describe Envm do
  subject do
    Envm.setup do |c|
      c.manifest_path = File.join(File.expand_path(__dir__), 'fixtures', 'env.yml')
    end
  end

  describe '[]' do
    context 'requesting a unregistered environment variable' do
      it 'raises an error' do
        expect { subject['XYZ'] }.to raise_error(Envm::NotFoundError)
      end
    end

    context 'requesting an environment variable' do
      context 'when set on the system' do
        let(:system_value) { 'https://myservice2.app' }

        before do
          ENV['EXTERNAL_API_URL'] = system_value
        end

        after do
          ENV['EXTERNAL_API_URL'] = nil
        end

        it 'returns a system value' do
          expect(subject['EXTERNAL_API_URL']).to eq(system_value)
        end
      end

      context 'when not set on the system' do
        before do
          ENV['DATABASE_URL'] = nil
        end

        it 'returns a default value' do
          expect(subject['EXTERNAL_API_URL']).to eq('https://myservice.app')
        end
      end
    end

    context 'requesting a secret environment variable' do
      context 'on production' do
        subject do
          Envm.setup do |c|
            c.manifest_path = File.join(File.expand_path(__dir__), 'fixtures', 'env.yml')
            c.environment = 'production'
          end
        end

        context 'set on the system' do
          let(:system_value) { 'sk_1' }

          before do
            ENV['STRIPE_API_KEY'] = system_value
          end

          after do
            ENV['STRIPE_API_KEY'] = nil
          end

          it 'returns the system value' do
            expect(subject['STRIPE_API_KEY']).to eq(system_value)
          end
        end

        context 'when not set on the system' do
          before do
            ENV['STRIPE_API_KEY'] = nil
          end

          it 'returns nil' do
            expect(subject['STRIPE_API_KEY']).to be_nil
          end
        end
      end

      context 'on development' do
        subject do
          Envm.setup do |c|
            c.manifest_path = File.join(File.expand_path(__dir__), 'fixtures', 'env.yml')
            c.environment = 'development'
          end
        end

        context 'set on the system' do
          let(:system_value) { 'sk_1' }

          before do
            ENV['STRIPE_API_KEY'] = system_value
          end

          after do
            ENV['STRIPE_API_KEY'] = nil
          end

          it 'returns the system value' do
            expect(subject['STRIPE_API_KEY']).to eq(system_value)
          end
        end

        context 'when not set on the system' do
          before do
            ENV['STRIPE_API_KEY'] = nil
          end

          it 'returns default value' do
            expect(subject['STRIPE_API_KEY']).to eq('sk_1aba1f5b4f9bd295d66af522655aa3d0')
          end
        end
      end
    end
  end
end
