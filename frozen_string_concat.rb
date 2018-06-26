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

__END__
Sample run with Ruby 2.5.0

Warming up --------------------------------------
 array without check     6.305k i/100ms
    array with check     6.601k i/100ms
                 dup     8.215k i/100ms
                  +=     1.899k i/100ms
Calculating -------------------------------------
 array without check     68.299k (± 5.9%) i/s -    340.470k in   5.002035s
    array with check     71.571k (± 5.3%) i/s -    363.055k in   5.087321s
                 dup     85.958k (± 5.4%) i/s -    435.395k in   5.079625s
                  +=     18.714k (±25.7%) i/s -     87.354k in   5.039241s

Comparison:
                 dup:    85958.4 i/s
    array with check:    71571.4 i/s - 1.20x  slower
 array without check:    68299.1 i/s - 1.26x  slower
                  +=:    18713.8 i/s - 4.59x  slower
