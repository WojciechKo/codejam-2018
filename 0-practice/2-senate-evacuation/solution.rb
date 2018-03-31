#!/usr/bin/env ruby

require 'logger'

log_file = File.open('log.log', 'a')
LOGGER = Logger.new(log_file)
LOGGER.level = Logger::DEBUG

class Evacuation
  ALPHABET = ('A' .. 'Z').to_a

  def steps(parties_members)
    first, *rest = parties_members.map.with_index do |count, index|
      (ALPHABET[index] * count).split('')
    end.sort_by(&:size).reverse

    LOGGER.debug("First: " + first.inspect)
    LOGGER.debug("Rest: " + rest.inspect)

    order = first.zip(*rest).flatten.compact
    LOGGER.debug("Order: " + order.inspect)

    [].tap do |result|
      until order.empty?
        if order.size == 3
          result << order.pop(1).join
        else
          result << order.pop(2).join
        end
      end
    end
  end
end

class Interface
  def self.read_input
    interface = Interface.new

    interface.read_test_cases.times do
      interface.read_number_of_parties
      interface.read_parties_members
      interface.write_evacuation_plan
    end
  end

  def read_test_cases
    gets.to_i.tap do |test_cases|
      LOGGER.debug("#" * 60)
      LOGGER.debug("<= Total test cases: #{test_cases}")
    end
  end

  def read_number_of_parties
    gets.to_i.tap do |parties|
      LOGGER.debug("." * 20)
      LOGGER.debug("<= Number of parties:  #{parties}")
    end
  end

  def read_parties_members
    gets.split.map(&:to_i).tap do |members|
      LOGGER.debug("<= Parties members:  #{members.inspect}")

      @parties_members = members
      @test_case = (test_case || 0) + 1
    end
  end

  def write_evacuation_plan
    steps = Evacuation.new.steps(parties_members).join(" ")
    log = "Case ##{test_case}: #{steps}"
    puts log

    LOGGER.debug("=> " + log)
  end

  private
  attr_reader :parties_members, :test_case
end

if __FILE__ == $0
  Interface.read_input
end
