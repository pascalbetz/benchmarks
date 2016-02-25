require 'benchmark/ips'

VALUES = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
Benchmark.ips do |x|
  x.compare!

  x.report('symbol') do
    VALUES.each(&:odd?)
  end

  x.report('method') do
    VALUES.each do |value|
      value.odd?
    end
  end

  x.report('send') do
    VALUES.each do |value|
      value.send(:odd?)
    end
  end

end
