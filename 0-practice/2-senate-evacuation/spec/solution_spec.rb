require 'stringio'
require_relative '../solution'

RSpec.describe 'solution' do
  subject do
    expect do
      Interface.read_input
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
        4
        2
        2 2
        3
        3 2 2
        3
        1 1 2
        3
        2 3 1
      INPUT
    end

    let(:result) do
      <<~OUTPUT
        Case #1: AB BA
        Case #2: AA BC C BA
        Case #3: C C AB
        Case #4: BA BB CA
      OUTPUT
    end

    it "should match output" do
      subject
    end
  end
end
