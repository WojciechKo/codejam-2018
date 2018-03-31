require 'stringio'
require_relative '../solution'

RSpec.describe StallPicker do
  subject do
    expect do
      StallPicker.new.pick(stalls)
    end.to output(result).to_stdout
  end
end

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
        5
        4 2
        5 2
        6 2
        1000 1000
        1000 1
      INPUT
    end

    let(:result) do
      <<~OUTPUT
        Case #1: 1 0
        Case #2: 1 0
        Case #3: 1 1
        Case #4: 0 0
        Case #5: 500 499
      OUTPUT
    end

    it "should match output" do
      subject
    end
  end
end
