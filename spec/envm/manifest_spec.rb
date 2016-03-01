require 'spec_helper'

describe Envm::Manifest do
  subject { described_class.new }

  describe "register and fetch" do
    context "when an env var is registered to manifest" do
      before do
        env_var = Envm::EnvVar.new(name: 'FOO', default: 1)
        subject.register(env_var)
      end

      it "returns value for env var" do
        expect(subject.fetch('FOO')).to eq(1)
      end
    end

    context "when an env var is not registered to manifest" do
      it "raises an error" do
        expect { subject.fetch('BAR') }.to raise_error(Envm::NotFoundError)
      end
    end
  end

  describe "#secrets" do
    before do
      subject.register Envm::EnvVar.new(name: 'FOO')
      subject.register Envm::EnvVar.new(name: 'BAR', secret: true)
    end

    it 'returns all secret env vars' do
      secrets = subject.secrets
      expect(secrets.size).to eq(1)
      expect(secrets.first.name).to eq('BAR')
    end
  end

  describe "#missing" do
    before do
      ENV['FOO'] = nil

      subject.register Envm::EnvVar.new(name: 'FOO')
      subject.register Envm::EnvVar.new(name: 'BAR', default: 'bar1')
    end

    it 'returns all env vars without a default or system value' do
      missing = subject.missing
      expect(missing.size).to eq(1)
      expect(missing.first.name).to eq('FOO')
    end
  end
end
