describe Envm::Config do
  describe 'setting the manifest path' do
    let(:path) { 'config/env.yml' }

    it 'properly sets the path' do
      Envm::Config.mainfest_path = path
      expect(Envm::Config.mainfest_path).to eq(path)
    end
  end
end
