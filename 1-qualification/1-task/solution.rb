#!/usr/bin/env ruby

require 'logger'

log_file = File.open('log.log', 'a')
LOG = Logger.new(log_file)
LOG.level = Logger::WARN

class Problem
  def initialize(shield, program)
    @shield = shield
    @program = program
  end

  attr_reader :shield, :program

  def solve
    return 'IMPOSSIBLE' unless solvable?

    hack_count = 0
    while get_hitpower > shield
      hack
      hack_count += 1
    end
    hack_count
  end

  def get_hitpower
    fire_power = 1
    hitpower = @program.split('').reduce(0) do |memo, element|
      if element == 'S'
        memo += fire_power
      elsif element == 'C'
        fire_power *= 2
      end
      memo
    end
    LOG.info("Fire power: #{hitpower}")
    hitpower
  end

  def hack
    index = @program.rindex('CS')
    LOG.info(@program)
    @program[index..index+1] = 'SC'
    LOG.info(@program)
  end

  def solvable?
    program.count('S') <= @shield
  end
end

class Interface
  def self.process
    gets.to_i.times do |test_case|
      LOG.info("##### Case ##{test_case + 1}")
      gets.split.tap do |shield, program|
        LOG.info "Shield: #{shield}"
        LOG.info "Program: #{program}"

        result = Problem.new(shield.to_i, program.to_s).solve
        output_log = "Case ##{test_case + 1}: #{result}"

        puts output_log
        LOG.debug(output_log)
      end
    end
  end
end

if __FILE__ == $0
  Interface.process
end
