describe 'Phony::Config' do
  describe 'load' do
    before do
      # NOTE: We redefine Phony as if it was not loaded for this set of tests.
      Object.__send__(:remove_const, :Phony) if Object.constants.include?(:Phony)

      load 'phony/config.rb'
    end

    after(:all) do
      # After running this suite, we load all of Phony for the following tests.
      load 'phony/config.rb'

      Phony::Config.load
    end

    it 'does not fail when loading all' do
      Phony::Config.load

      expect(Phony.split('15551115511')).to eq %w[1 555 111 5511]
    end

    it 'raises when a CC is used that has not been loaded.' do
      Phony::Config.load('41')

      expect { Phony.split('15551115511') }.to raise_error(Phony::SplittingError)
    end

    it 'raises when a CC is used that has not been loaded.' do
      Phony::Config.load(only: ['41'])

      expect { Phony.split('15551115511') }.to raise_error(Phony::SplittingError)
    end

    it 'raises when a CC is used that has not been loaded.' do
      Phony::Config.load(except: ['1'])

      expect { Phony.split('15551115511') }.to raise_error(Phony::SplittingError)
    end

    it 'does not raise when a CC is used that has been loaded.' do
      Phony::Config.load(except: ['41'])

      expect(Phony.split('15551115511')).to eq %w[1 555 111 5511]
    end
  end
end
