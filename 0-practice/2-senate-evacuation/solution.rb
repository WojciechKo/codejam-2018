#!/usr/bin/env ruby

require 'logger'

log_file = File.open('log.log', 'a')
LOGGER = Logger.new(log_file)
LOGGER.level = Logger::DEBUG

class Evacuation
  ALPHABET = ('A' .. 'Z').to_a

  def initialize(parties_members)
    @parties_members = parties_members
  end

  def steps
    letter_from_index = -> index { ALPHABET[index - 1] }

    [[1, 1], [1, 1]].map do |step|
      step.map(&letter_from_index).join
    end
  end

  private
  attr_reader :parties_members
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
      LOGGER.debug("<= Test cases: #{test_cases}")

      @test_cases = test_cases
    end
  end

  def read_number_of_parties
    gets.to_i.tap do |parties|
      LOGGER.debug("#" * 60)
      LOGGER.debug("<= Number of parties:  #{parties}")
    end
  end

  def read_parties_members
    gets.split.map(&:to_i).tap do |*members|
      LOGGER.debug("<= Parties members:  #{members}")

      @evacuation = Evacuation.new(members)
      @test_case = (test_case || 0) + 1
    end
  end

  def write_evacuation_plan
    steps = evacuation.steps.join(" ")
    log = "Case ##{test_case}: #{steps}"

    puts log
    LOGGER.debug(log)
  end

  private
  attr_reader :evacuation, :test_case
end

if __FILE__ == $0
  Interface.read_input
end
