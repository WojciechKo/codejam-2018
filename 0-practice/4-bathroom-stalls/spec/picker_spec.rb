require 'stringio'
require_relative '../solution'

RSpec.describe StallPicker do
  describe '#pick' do
    it 'works for 4 stallsf' do
      picker = StallPicker.new(4)
      expect(picker.pick).to eq([1, 2])
      expect(picker.pick).to eq([0, 1])
      expect(picker.pick).to eq([0, 0])
      expect(picker.pick).to eq([0, 0])
    end

    it 'works for 5 stallsf' do
      picker = StallPicker.new(5)
      expect(picker.pick).to eq([2, 2])
      expect(picker.pick).to eq([0, 1])
      expect(picker.pick).to eq([0, 1])
      expect(picker.pick).to eq([0, 0])
      expect(picker.pick).to eq([0, 0])
    end

    it 'works for 6 stallsf' do
      picker = StallPicker.new(6)
      expect(picker.pick).to eq([2, 3])
      expect(picker.pick).to eq([1, 1])
      expect(picker.pick).to eq([0, 1])
      expect(picker.pick).to eq([0, 0])
      expect(picker.pick).to eq([0, 0])
      expect(picker.pick).to eq([0, 0])
    end

    it 'works for 7 stallsf' do
      picker = StallPicker.new(7)
      expect(picker.pick).to eq([3, 3])
      expect(picker.pick).to eq([1, 1])
      expect(picker.pick).to eq([1, 1])
      expect(picker.pick).to eq([0, 0])
      expect(picker.pick).to eq([0, 0])
      expect(picker.pick).to eq([0, 0])
      expect(picker.pick).to eq([0, 0])
    end

    it 'works for 8 stallsf' do
      picker = StallPicker.new(8)
      expect(picker.pick).to eq([3, 4])
      expect(picker.pick).to eq([1, 2])
      expect(picker.pick).to eq([1, 1])
      expect(picker.pick).to eq([0, 1])
      expect(picker.pick).to eq([0, 0])
      expect(picker.pick).to eq([0, 0])
      expect(picker.pick).to eq([0, 0])
      expect(picker.pick).to eq([0, 0])
    end
  end
end
