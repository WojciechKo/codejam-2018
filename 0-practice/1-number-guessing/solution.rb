#!/usr/bin/env ruby

require 'logger'

log_file = File.open('log.log', 'a')
LOGGER = Logger.new(log_file)
LOGGER.level = Logger::DEBUG

class Guessing
  def initialize(min, max)
    @range = (min .. max)
  end

  def make_a_guess
    rand(range)
  end

  def guess_too_big(guess)
    @range = (range.min .. guess - 1)
  end

  def guess_too_small(guess)
    @range = (guess + 1 .. range.max)
  end

  private
  attr_reader :range
end

class Interface
  def read_test_cases
    @guessings = []

    gets.to_i.tap do |test_cases|
      LOGGER.debug("<= Test cases: #{test_cases}")
    end
  end

  def read_range
    gets.split.map(&:to_i).tap do |lower, upper|
      LOGGER.debug("#" * 60)
      LOGGER.debug("<= New guessing, range:  (#{lower}, #{upper}]")

      @guessings.push(Guessing.new(lower + 1, upper))
    end
  end

  def read_tries
    gets.to_i.tap do |tries|
      LOGGER.debug("<= Tries:  #{tries}")
    end
  end

  def make_a_guess
    @guessings.last.make_a_guess.tap do |guess|
      LOGGER.debug("=> Guess:  #{guess}")

      puts guess
      STDOUT.flush
    end
  end

  def read_outcome
    gets.chomp.to_sym.tap do |outcome|
      LOGGER.debug("<= Outcome:  #{outcome}")
    end
  end

  def guess_too_big(guess)
    @guessings.last.guess_too_big(guess)
  end

  def guess_too_small(guess)
    @guessings.last.guess_too_small(guess)
  end
end

def start_guessing
  interface = Interface.new

  interface.read_test_cases.times do
    interface.read_range

    interface.read_tries.times do
      guess = interface.make_a_guess

      case interface.read_outcome
        when :CORRECT then break
        when :TOO_BIG then interface.guess_too_big(guess)
        when :TOO_SMALL then interface.guess_too_small(guess)
        else exit
      end
    end
  end
end

if __FILE__ == $0
  start_guessing
end
