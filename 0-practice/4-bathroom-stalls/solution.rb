#!/usr/bin/env ruby

require 'logger'

log_file = File.open('log.log', 'a')
LOGGER = Logger.new(log_file)
LOGGER.level = Logger::WARN

class Stall < Struct.new(:occupied, :index, :left, :right)
  def initialize(*args)
    super
    @dirty = true
  end

  def left=(left)
    super
    @dirty = true
  end

  def right=(right)
    super
    @dirty = true
  end

  def occupied=(occupied)
    super
    @dirty = true
  end

  def <=>(other_stall)
    value <=> other_stall.value
  end

  def value
    if @dirty
      @dirty = false
      @value = calculate_value
    else
      @value
    end
  end

  def minmax
    [left, right].minmax
  end

  private

  def calculate_value
    return [0, 0] if occupied

    minmax + [-index]
  end
end

class StallPicker
  def initialize(stalls_count)
    @stalls = Array.new(stalls_count) do |number|
      Stall.new(false, number, number, stalls_count - number - 1)
    end
    @available_stalls = @stalls.clone
    LOGGER.debug("## Init stalls: #{@stalls}")
  end

  def pick_multiple(n)
    n.times.reduce(nil) { pick }
  end

  def pick
    @available_stalls.max.tap do |selected_stall|
      LOGGER.debug("#### Selected: #{selected_stall}")
      make_stall_occupied!(selected_stall.index)
    end
  end

  private
  attr_reader :stalls, :available_stalls

  def make_stall_occupied!(selected_stall)
    @stalls[selected_stall].occupied = true

    @stalls.take(selected_stall).reverse.each_with_index do |stall, index|
      stall.right = index
      LOGGER.debug("#### Update on left side: #{stall}")
      break if stall.occupied
    end

    @stalls.drop(selected_stall + 1).each_with_index do |stall, index|
      stall.left = index
      LOGGER.debug("#### Update on right side: #{stall}")
      break if stall.occupied
    end

    @available_stalls.delete_if { |stall| stall.index == selected_stall }

    LOGGER.debug("## After update: #{@stalls}")
  end
end

class Interface
  def self.process
    gets.to_i.times do |test_case|
      LOGGER.info("#" * 80)
      gets.split.map(&:to_i).tap do |stalls, people|
        LOGGER.debug("Stalls : #{stalls}")
        LOGGER.debug("People : #{people}")

        stall = StallPicker.new(stalls).pick_multiple(people)
        min, max = stall.minmax
        output_log = "Case ##{test_case + 1}: #{max} #{min}"
        puts output_log
        LOGGER.debug(output_log)
      end
    end
  end
end

if __FILE__ == $0
  Interface.process
end
