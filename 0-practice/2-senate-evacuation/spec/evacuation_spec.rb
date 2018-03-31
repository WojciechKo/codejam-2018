require 'stringio'
require_relative '../solution'

RSpec.describe Evacuation do
  subject { described_class.new(parties_members) }
  let(:parties_members) do
    [9, 4, 1, ]
  end

  it 'AA' do
    expect(subject.steps).to start_with('AA', 'AA')
  end
end
