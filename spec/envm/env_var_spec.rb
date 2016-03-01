require 'spec_helper'

describe Envm::EnvVar do
  describe "#secret?" do
    context "when secret was not set" do
      subject { described_class.new(name: 'FOO', secret: true) }

      it 'returns true' do
        expect(subject).to be_secret
      end
    end

    context "when secret was not set" do
      subject { described_class.new(name: 'FOO') }

      it 'returns false' do
        expect(subject).to_not be_secret
      end
    end
  end

  describe "#value" do
    subject do
      described_class.new(name: 'FOO', default: 'baz')
    end

    context "when set on system" do
      before do
        ENV['FOO'] = 'bar'
      end

      after do
        ENV['FOO'] = nil
      end

      it "returns system value" do
        expect(subject.value).to eq('bar')
      end
    end

    context "when not set on system" do
      before do
        ENV['FOO'] = nil
      end

      it "returns default value" do
        expect(subject.value).to eq('baz')
      end
    end
  end
end
