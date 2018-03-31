#!/usr/bin/env ruby

require 'logger'

log_file = File.open('log.log', 'a')
LOGGER = Logger.new(log_file)
LOGGER.level = Logger::WARN

class StallPicker
  Stall = Struct.new(:occupied, :index, :left, :right)

  def initialize(stalls_count)
    @models = Array.new(stalls_count) do |number|
      Stall.new(false, number, number, stalls_count - number - 1)
    end
    LOGGER.debug("## Init stalls: #{@models}")
  end

  def pick
    pick_next.tap do |selected_stall|
      LOGGER.debug("#### Selected stall: #{selected_stall}")
      make_stall_occupied!(selected_stall.index)
    end
  end

  private
  attr_reader :models

  def pick_next
    @models.reject do |stall|
      stall.occupied
    end.min_by do |stall|
      min, max = [stall.left, stall.right].minmax
      [-min, -max, stall.index]
    end
  end

  def make_stall_occupied!(selected_stall)
    @models[selected_stall].occupied = true

    @models.take(selected_stall).reverse.each_with_index do |stall, index|
      stall.right = index
      LOGGER.debug("#### Update on left side: #{stall}")
      break if stall.occupied
    end

    @models.drop(selected_stall + 1).each_with_index do |stall, index|
      stall.left = index
      LOGGER.debug("#### Update on right side: #{stall}")
      break if stall.occupied
    end

    LOGGER.debug("## After update: #{@models}")
  end
end

class BathroomStalls
  def calculate(stalls, people)
    picker = StallPicker.new(stalls)

    stall = people.times.reduce(nil) do
      picker.pick.tap do |stall|
        LOGGER.debug("# Left: #{stall.left}, right: #{stall.right} stall to take: #{stall.index}")
      end
    end

    [stall.left, stall.right].minmax.reverse
  end
end

class Interface
  def self.process
    gets.to_i.times do |test_case|
      LOGGER.info("#" * 80)
      gets.split.map(&:to_i).tap do |stalls, people|
        LOGGER.debug("Stalls : #{stalls}")
        LOGGER.debug("People : #{people}")

        min, max = BathroomStalls.new.calculate(stalls, people)
        output_log = "Case ##{test_case + 1}: #{min} #{max}"
        puts output_log
        LOGGER.debug(output_log)
      end
    end
  end
end

if __FILE__ == $0
  Interface.process
end
