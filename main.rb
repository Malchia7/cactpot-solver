require './solver.rb'

known = [
  1,0,0,
  0,3,0,
  8,2,0
]
raise "bad known set" unless (known.uniq - [0]).length == 4 # must be exactly 3 after unique and removing zeroes to ensure we didn't accidentally enter the same number in two positions

solver = CactpotSolver::Solver.new known

result = solver.calc_all
best_row = {key: "", high_average: 0, high_outcomes: 0.0}
result.each do |k,v|
  puts "#{k} : #{v}"
  if v[:outcome_ratio] >= best_row[:high_outcomes] then
    if v[:average] > best_row[:high_average] then
      best_row[:key] = k
      best_row[:high_outcomes] = v[:outcome_ratio]
      best_row[:high_average] = v[:average]
    end
  end
end
puts "The best choice is!!!! #{best_row[:key]} with an outcome ratio of #{result[best_row[:key]][:good_outcome]}:#{result[best_row[:key]][:bad_outcome]} and average value of #{best_row[:high_average]}"
