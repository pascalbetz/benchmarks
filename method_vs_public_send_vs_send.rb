# frozen_string_literal: true

require "benchmark/ips"

class Obj
  def hello
  end
end

obj = Obj.new

Benchmark.ips do |x|
  x.compare!

  x.report("method + call") do
    obj.method(:hello).call
  end

  x.report("public_send") do
    obj.public_send(:hello)
  end

  x.report("send") do
    obj.send(:hello)
  end
end

__DATA__
Sample Run with Ruby 2.5.0
Warming up --------------------------------------
       method + call   157.777k i/100ms
         public_send   246.986k i/100ms
                send   267.647k i/100ms
Calculating -------------------------------------
       method + call      2.571M (± 2.7%) i/s -     12.938M in   5.035042s
         public_send      6.042M (± 3.3%) i/s -     30.379M in   5.033482s
                send      7.656M (± 4.0%) i/s -     38.274M in   5.007630s

Comparison:
                send:  7655632.3 i/s
         public_send:  6041856.5 i/s - 1.27x  slower
       method + call:  2571436.8 i/s - 2.98x  slower
