require 'benchmark/ips'
one = -> (value) { value == 1 }
two = -> (value) { value == 2 }
thing = 1

Benchmark.ips do |x|
  x.report('case with inlined lambdas') do
    result = case thing
    when -> (value) { value == 1 } then 'one'
    when -> (value) { value == 2 } then 'two'
    else 'something else'
    end
  end

  x.report('case with lambdas') do
    result = case thing
    when one then 'one'
    when two then 'two'
    else 'something else'
    end
  end

  x.report('if/else') do
    result = if thing == 1
      'one'
    elsif thing == 2
      'two'
    else
      'something else'
    end
  end
end
