require 'envm'

describe Envm do
  describe "VERSION" do
    it "returns version" do
      expect(Envm::VERSION).to_not be_nil
    end
  end

  describe "[]" do
    let(:name) { "DATABASE_URL" }

    before do
      Envm::Config.mainfest_path = File.join(File.expand_path(__dir__), "fixtures", "env.yml")
      Envm.setup
    end

    context "when given a default value" do
      it "returns the default value" do
        expect(Envm["DATABASE_URL"]).to eq("mysql2://app@127.0.0.1:3306/mydb")
      end
    end

    context "when given unknown variable" do
      it "raises an error" do
        expect { Envm["XYZ"] }.to raise_error(Envm::NotFoundError)
      end
    end

    describe "requesting a required env var" do
      let(:env) { "production" }

      context "when same env" do
        before do
          Envm::Config.environment = env
          ENV["REQUIRED_ON_PROD"] = "my_secret"
        end

        after do
          ENV["REQUIRED_ON_PROD"] = nil
        end

        it "returns the system value" do
          expect(Envm["REQUIRED_ON_PROD"]).to eq(ENV["REQUIRED_ON_PROD"])
        end
      end

      context "when not same env" do
        before { Envm::Config.environment = "zxy" }

        context "when contains default value" do
          it "returns the default value" do
            expect(Envm["REQUIRED_WITH_DEFAULT_ON_PROD"]).to eq("default")
          end
        end

        context "when doesnt contain default value" do
          it "returns the blank value" do
            expect(Envm["REQUIRED_ON_PROD"]).to be_nil
          end
        end
      end
    end
  end
end
