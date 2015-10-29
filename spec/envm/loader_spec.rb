describe Envm::ManifestLoader do
  before do
    Envm::Config.manifest_path = File.join(File.expand_path(__dir__), "..", "fixtures", "env.yml")
  end

  describe '#load' do
    it 'returns key value of vars' do
      loaded_vars = described_class.load
      expect(loaded_vars["DATABASE_URL"]).to_not be_nil
      expect(loaded_vars["AWS_ACCESS_KEY_ID"]).to_not be_nil

      expect(loaded_vars["XYZ"]).to be_nil
    end
  end
end
