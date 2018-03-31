#!/usr/bin/env ruby

require 'logger'

log_file = File.open('log.log', 'a')
LOGGER = Logger.new(log_file)
LOGGER.level = Logger::DEBUG

class BathroomStalls
  def calculate(n, k)
    [0, 0]
  end
end

class Interface
  def self.process
    gets.to_i.times do |test_case|
      LOGGER.debug("#" * 60)

      gets.split.map(&:to_i).tap do |n, k|
        LOGGER.debug("N : #{n}")
        LOGGER.debug("K : #{k}")

        output = BathroomStalls.new.calculate(n, k)
        output = "Case ##{test_case + 1}: #{output[0]} #{output[1]}"
        puts output
        LOGGER.debug(output)
      end
    end
  end
end

if __FILE__ == $0
  Interface.process
end
