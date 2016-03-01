require 'spec_helper'

describe Envm::Loader do
  subject { described_class.new(config) }

  let(:config) do
    Envm::Config.new.tap do |c|
      c.environment = 'development'
      c.manifest_path = File.join(__dir__, "..", "fixtures", "env.yml")
    end
  end

  describe '#load' do
    context "when loading from a non-secret environment" do
      describe 'returned manifest' do
        before do
          @manifest = subject.load
        end

        it 'EXTERNAL_API_URL returns default value' do
          value = @manifest.fetch('EXTERNAL_API_URL')
          expect(value).to eq('https://myservice.app')
        end

        it 'STRIPE_API_KEY returns default value' do
          value = @manifest.fetch('STRIPE_API_KEY')
          expect(value).to eq('sk_1aba1f5b4f9bd295d66af522655aa3d0')
        end

        it 'AWS_SECRET_KEY returns nil' do
          value = @manifest.fetch('AWS_SECRET_KEY')
          expect(value).to be_nil
        end
      end
    end

    context "when loading from secret environment" do
      let(:config) do
        Envm::Config.new.tap do |c|
          c.environment = 'production'
          c.manifest_path = File.join(__dir__, "..", "fixtures", "env.yml")
        end
      end

      describe 'returned manifest' do
        before do
          @manifest = subject.load
        end

        it 'EXTERNAL_API_URL returns default value' do
          value = @manifest.fetch('EXTERNAL_API_URL')
          expect(value).to eq('https://myservice.app')
        end

        it 'STRIPE_API_KEY returns nil' do
          value = @manifest.fetch('STRIPE_API_KEY')
          expect(value).to be_nil
        end

        it 'AWS_SECRET_KEY returns nil' do
          value = @manifest.fetch('AWS_SECRET_KEY')
          expect(value).to be_nil
        end
      end
    end
  end
end
