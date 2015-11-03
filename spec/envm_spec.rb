require 'envm'

describe Envm do
  describe "[]" do
    before do
      Envm::Config.manifest_path = File.join(File.expand_path(__dir__), "fixtures", "env.yml")
      Envm.setup
    end

    context "requesting an env var with multiple default values" do
      context "when in a staging environment" do
        let(:env) { "staging" }
        before do
          Envm::Config.environment = env
        end
        context "when not set on the system" do
          it "returns the staging default value" do
            expect(Envm["MULTIPLE_DEFAULT_VALUES"]).to eq("staging_default")
          end
        end

        context "when set on the system" do
          let(:system_value) { "mysecret"}
          before do
            ENV["MULTIPLE_DEFAULT_VALUES"] = system_value
          end

          after do
            ENV["MULTIPLE_DEFAULT_VALUES"] = nil
          end

          it "returns the set value" do
            expect(Envm["MULTIPLE_DEFAULT_VALUES"]).to eq("mysecret")
          end
        end
      end

      context "when in a production environment" do
        let(:env) { "production" }
        before do
          Envm::Config.environment = env
        end

        context "when required for environment but not set on system" do
          before do
            ENV["MULTIPLE_DEFAULT_VALUES"] = nil
          end
          it "returns an error despite having a default provided" do
            expect{Envm["MULTIPLE_DEFAULT_VALUES"] }.to raise_error(Envm::NotSetError)
          end
        end
      end
    end


    context "requesting an undefined env var" do
      it "raises an error" do
        expect { Envm["XYZ"] }.to raise_error(Envm::NotFoundError)
      end
    end

    context "requesting an optional env var" do
      context "when set on the system" do
        let(:system_value) { "pg://127.0.0.1:3306/mydb" }

        before do
          ENV["DATABASE_URL"] = system_value
        end

        after do
          ENV["DATABASE_URL"] = nil
        end

        it "returns a system value" do
          expect(Envm["DATABASE_URL"]).to eq(system_value)
        end
      end

      context "when not set on the system" do
        before do
          ENV["DATABASE_URL"] = nil
        end

        it "returns a default value" do
          expect(Envm["DATABASE_URL"]).to eq("mysql2://app@127.0.0.1:3306/mydb")
        end
      end
    end

    context "requesting a required env var" do
      context "when required on all environments" do
        before do
          Envm::Config.environment = "random environment"
        end
        context "when not set on the system" do
          before do
            ENV["AWS_SECRET_ACCESS_KEY"] = nil
          end

          it "raises an error" do
            expect { Envm["AWS_SECRET_ACCESS_KEY"] }.to raise_error(Envm::NotSetError)
          end
        end
      end

      context "when on same environment " do
        let(:env) { "production" }

        before do
          Envm::Config.environment = env
        end

        context "when set on the system" do
          let(:system_value) { "mysecret"}

          before do
            ENV["REQUIRED_ON_PROD"] = system_value
          end

          after do
            ENV["REQUIRED_ON_PROD"] = nil
          end

          it "returns the system value" do
            expect(Envm["REQUIRED_ON_PROD"]).to eq(system_value)
          end
        end

        context "when not set on the system" do
          before do
            ENV["REQUIRED_ON_PROD"] = nil
          end

          it "raises an error" do
            expect { Envm["REQUIRED_ON_PROD"] }.to raise_error(Envm::NotSetError)
          end
        end
      end

      context "when not on same environment" do
        let(:env) { "production" }

        before do
          Envm::Config.environment = "zyx"
        end

        context "when set on the system" do
          let(:system_value) { "mysecret"}

          before do
            ENV["REQUIRED_ON_PROD"] = system_value
          end

          after do
            ENV["REQUIRED_ON_PROD"] = nil
          end

          it "returns the system value" do
            expect(Envm["REQUIRED_ON_PROD"]).to eq(system_value)
          end
        end

        context "when not set on the system" do
          before do
            ENV["REQUIRED_WITH_DEFAULT_ON_PROD"] = nil
          end

          context "have default value" do
            it "returns the default value" do
              expect(Envm["REQUIRED_WITH_DEFAULT_ON_PROD"]).to eq("default")
            end
          end

          context "does not have default value" do
            it "returns nil" do
              expect(Envm["REQUIRED_ON_PROD"]).to be_nil
            end
          end
        end
      end
    end
  end
end
