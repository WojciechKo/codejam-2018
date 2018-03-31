#!/usr/bin/env ruby

require 'logger'

log_file = File.open('log.log', 'a')
LOGGER = Logger.new(log_file)
LOGGER.level = Logger::INFO

class StallPicker
  def pick(stalls)
    @stalls = [true, *stalls, true]

    LOGGER.debug("## Stalls: #{stalls.inspect}")

    stalls.map.with_index do |element, index|
      LOGGER.debug("### Element index: #{index}")
      if element
        LOGGER.debug("### Occupied")
        next
      end

      left_space = left_space(index)
      right_space = right_space(index)

      LOGGER.debug("### Left side: #{left_space}, right side: #{right_space}")

      min, max = [left_space, right_space].minmax

      element ? nil : [min, max, index]
    end.compact.sort_by do |min, max, index|
      LOGGER.debug("### Min: #{min}, Max: #{max}")
      [-min, -max, index]
    end.first.tap do |result|
      LOGGER.debug("#### Result: #{result}")
    end
  end

  private

  def left_space(index)
    #TODO take(index)
    space = @stalls[0 .. index].reverse
    LOGGER.debug("#### Left side : #{space}")
    space.index(true)
  end

  def right_space(index)
    space = @stalls.drop(index + 2)
    LOGGER.debug("#### Right side : #{space}")
    space.index(true)
  end
end

class BathroomStalls
  Stall = Struct.new(:index, :occupied, :left, :right)

  def calculate(n, k)
    init_stalls(n)

    k.times.map do |person|
      process_entrance(person)
    end

    output
  end

  private
  attr_reader :stalls

  def init_stalls(stales_count)
    @stalls = Array.new(stales_count) { false}
  end

  def process_entrance(person)
    @min, @max, stall = StallPicker.new.pick(stalls)
    LOGGER.debug("# Min: #{@min}, max: #{@max} stall to take: #{stall}")
    occupy_stall(stall)
    LOGGER.info("Stalls after person #{person + 1}")
    LOGGER.info(stalls.inspect)
  end

  def occupy_stall(stall)
    stalls[stall] = true
  end

  def output
    [@max, @min]
  end
end

class Interface
  def self.process
    gets.to_i.times do |test_case|
      LOGGER.info("#" * 80)
      gets.split.map(&:to_i).tap do |stalls, people|
        LOGGER.debug("Stalls : #{stalls}")
        LOGGER.debug("People : #{people}")

        output = BathroomStalls.new.calculate(stalls, people)
        output_log = "Case ##{test_case + 1}: #{output[0]} #{output[1]}"
        puts output_log
        LOGGER.debug(output_log)
      end
    end
  end
end

if __FILE__ == $0
  Interface.process
end
