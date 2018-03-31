#!/usr/bin/env ruby

require 'logger'

log_file = File.open('log.log', 'a')
LOGGER = Logger.new(log_file)
LOGGER.level = Logger::DEBUG

class SpeedCalculator
  def calculate(distance, horses)
    slowest_horse_time = horses.map do |starting_point, speed|
      (distance - starting_point).to_f / speed
    end.max

    LOGGER.debug("Slowest horse time: #{slowest_horse_time}")

    (distance / slowest_horse_time).tap do |speed|
      LOGGER.debug("Speed: #{speed}")
    end
  end
end

class Interface
  def self.process
    gets.to_i.times do |test_case|
      LOGGER.debug("#" * 60)

      gets.split.map(&:to_i).tap do |distance, horse_count|
        LOGGER.debug("Total distance: #{distance}")
        horses = []
        horse_count.times do
          gets.split.map(&:to_i).tap do |horse_distance, horse_speed|
            LOGGER.debug("Horse distance: #{horse_distance}")
            LOGGER.debug("Horse speed: #{horse_speed}")
            horses.push([horse_distance, horse_speed])
          end
        end

        speed = SpeedCalculator.new.calculate(distance, horses)
        output = "Case ##{test_case + 1}: #{'%.6f' % speed}"
        puts output
        LOGGER.debug(output)
      end
    end
  end
end

if __FILE__ == $0
  Interface.process
end
