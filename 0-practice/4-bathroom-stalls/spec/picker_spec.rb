require 'stringio'
require_relative '../solution'

RSpec.describe StallPicker do
  it 'works for 4 stalls' do
    picker = StallPicker.new(4)
    expect(picker.pick.index).to eq(1)
    expect(picker.pick.index).to eq(2)
    expect(picker.pick.index).to eq(0)
    expect(picker.pick.index).to eq(3)
  end

  it 'works for 5 stalls' do
    picker = StallPicker.new(5)
    expect(picker.pick.index).to eq(2)
    expect(picker.pick.index).to eq(0)
    expect(picker.pick.index).to eq(3)
    expect(picker.pick.index).to eq(1)
    expect(picker.pick.index).to eq(4)
  end

  it 'works for 6 stalls' do
    picker = StallPicker.new(6)
    expect(picker.pick.index).to eq(2)
    expect(picker.pick.index).to eq(4)
    expect(picker.pick.index).to eq(0)
    expect(picker.pick.index).to eq(1)
    expect(picker.pick.index).to eq(3)
    expect(picker.pick.index).to eq(5)
  end

  it 'works for 7 stalls' do
    picker = StallPicker.new(7)
    expect(picker.pick.index).to eq(3)
    expect(picker.pick.index).to eq(1)
    expect(picker.pick.index).to eq(5)
    expect(picker.pick.index).to eq(0)
    expect(picker.pick.index).to eq(2)
    expect(picker.pick.index).to eq(4)
    expect(picker.pick.index).to eq(6)
  end
end
