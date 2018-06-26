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
