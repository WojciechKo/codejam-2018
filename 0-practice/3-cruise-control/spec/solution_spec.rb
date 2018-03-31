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
        3
        2525 1
        2400 5
        300 2
        120 60
        60 90
        100 2
        80 100
        70 10
      INPUT
    end

    let(:result) do
      <<~OUTPUT
        Case #1: 101.000000
        Case #2: 100.000000
        Case #3: 33.333333
      OUTPUT
    end

    it "should match output" do
      subject
    end
  end
end
