#!/usr/bin/env ruby

require 'logger'

log_file = File.open('log.log', 'a')
LOG = Logger.new(log_file)
LOG.level = Logger::WARN

class Problem
  def initialize(array)
    @array = array
  end

  attr_reader :array

  def solve
    error = error?
    error || 'OK'
  end

  def error?
    grouped = array.each_with_index.group_by { |e, i| i%2 }
    even = grouped[0].map { |e, i| e }.sort!
    odd = grouped[1].map { |e, i| e }.sort!

    LOG.info even
    LOG.info odd

    for i in 0..array.length-2
      if i % 2 == 0
        LOG.info 'even'
        next if even[i/2] <= odd[i/2]
      else
        LOG.info 'odd'
        next if odd[i/2] <= even[i/2 + 1]
      end
      LOG.info 'return i'
      return i
    end

    LOG.info 'should not be here'
    return false
  end
end

class Interface
  def self.process
    gets.to_i.times do |test_case|
      LOG.info("##### Case ##{test_case + 1}")
      length = gets.to_i
      array = gets.split.map(&:to_i)
      LOG.info(array)
      result = Problem.new(array).solve
      output_log = "Case ##{test_case + 1}: #{result}"

      puts output_log
      LOG.debug(output_log)
    end
  end
end

if __FILE__ == $0
  Interface.process
end
