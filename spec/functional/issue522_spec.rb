require 'spec_helper'

# Tajikistan (+992): the trunk code '8' is also the leading digit of the
# MegaFon mobile NDCs (88x), so normalizing must not strip it.
describe 'issue #522' do
  it 'does not drop the leading 8 of a MegaFon 88x mobile number when normalizing' do
    expect(Phony.normalize('+992 88 123 4567')).to eq '992881234567'
  end

  it 'is idempotent for an already-normalized MegaFon 88x number' do
    expect(Phony.normalize('992881234567')).to eq '992881234567'
  end
end
