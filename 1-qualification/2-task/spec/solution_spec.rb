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
        5
        5 6 8 4 3
        3
        8 9 7
        4
        2 1 4 5
      INPUT
    end

    let(:result) do
      <<~OUTPUT
        Case #1: OK
        Case #2: 1
        Case #3: 0
      OUTPUT
    end

    it "should match output" do
      subject
    end
  end
end
