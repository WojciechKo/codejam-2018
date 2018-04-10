require 'stringio'
require_relative '../solution'

RSpec.describe 'solution' do
  subject do
    expect do
      Interface.process
    end.to output(result).to_stdout
  end

  before do
    $stdin = StringIO.new(input)
  end

  after do
    $stdin = STDIN
  end

  context 'Example' do
    let(:input) do
      <<~INPUT
        6
        1 CS
        2 CS
        1 SS
        6 SCCSSC
        2 CC
        3 CSCSS
      INPUT
    end

    let(:result) do
      <<~OUTPUT
        Case #1: 1
        Case #2: 0
        Case #3: IMPOSSIBLE
        Case #4: 2
        Case #5: 0
        Case #6: 5
      OUTPUT
    end

    it "should match output" do
      subject
    end
  end
end
