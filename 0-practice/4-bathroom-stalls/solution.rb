#!/usr/bin/env ruby

require 'logger'

log_file = File.open('log.log', 'a')
LOGGER = Logger.new(log_file)
LOGGER.level = Logger::DEBUG

class StallPicker
  def initialize(stalls_count)
    @spaces = [stalls_count]
    LOGGER.debug("## Init spaces: #{@spaces}")
  end

  def pick_multiple(n)
    n.times.reduce(nil) { pick }
  end

  def pick
    biggest_space = @spaces.pop
    half = biggest_space / 2
    div_rest = biggest_space % 2
    min = half != 0 && half + div_rest - 1 || 0
    @spaces.unshift(min, half)
    [min, half]
  end
end

class Interface
  def self.process
    gets.to_i.times do |test_case|
      LOGGER.info("#" * 80)
      gets.split.map(&:to_i).tap do |stalls, people|
        LOGGER.debug("Stalls : #{stalls}")
        LOGGER.debug("People : #{people}")

        min, max = StallPicker.new(stalls).pick_multiple(people)
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
