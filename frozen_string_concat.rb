# frozen_string_literal: true

require "benchmark/ips"
require "securerandom"
strings = 100.times.map do
  if rand > 0.1
    SecureRandom.hex
  else
    nil
  end
end

Benchmark.ips do |x|
  x.compare!

  x.report("array without check") do
    array = []
    strings.each do |string|
      array << string
    end
    array.compact.join(" ")
  end

  x.report("array with check") do
    array = []
    strings.each do |string|
      array << string if string
    end
    array.join("")
  end

  x.report("dup") do
    result = "".dup
    strings.each do |string|
      result << string if string
    end
  end
  x.report("+=") do
    result = ""
    strings.each do |string|
      result += string if string
    end
  end
end
