require 'spec_helper'

describe Envm::EnvVar do
  describe "#required_and_missing?" do
    let(:env) { {} }

    subject(:env_var) do
      described_class.new(
        name: 'A_KEY',
        required: required_environments,
        env: env,
      )
    end

    before do
      Envm::Config.environment = "test_env"
    end

    after do
      Envm::Config.environment = nil
    end

    context "when the required enviroment matches the Config.environment" do
      let(:required_environments) { ["test_env"] }

      context "when the key is missing from the ENV hash" do
        it "should be required" do
          expect(env_var).to be_required
        end

        it "should be missing" do
          expect(env_var).to be_missing
        end
      end

      context "when the key is present from the ENV hash" do
        let(:env) { { 'A_KEY' => "present" } }

        it "should be required" do
          expect(env_var).to be_required
        end

        it "should not be missing" do
          expect(env_var).to_not be_missing
        end
      end
    end

    context "when the required enviroment does not matches the Config.environment" do
      let(:required_environments) { ["another_env"] }

      context "when the key is missing from the ENV hash" do
        it "should not be required" do
          expect(env_var).to_not be_required
        end

        it "should be missing" do
          expect(env_var).to be_missing
        end
      end

      context "when the key is present from the ENV hash" do
        let(:env) { { 'A_KEY' => "present" } }

        it "should not be required" do
          expect(env_var).to_not be_required
        end

        it "should not be missing" do
          expect(env_var).to_not be_missing
        end
      end
    end
  end
end
