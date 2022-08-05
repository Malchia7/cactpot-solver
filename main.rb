require './solver.rb'

known = ARGV[0].split(',').map do |it| it.to_i end

# known = [
#   3,0,4,
#   0,0,0,
#   1,0,5
# ]
raise "bad known set" unless (known.uniq - [0]).length == 4 # must be exactly 4 after unique and removing zeroes to ensure we didn't accidentally enter the same number in two positions

solver = CactpotSolver::Solver.new known

result = solver.calc_all
$best_row = {key: "", high_average: 0, high_outcomes: 0.00}

def update_best_row(key, value)
  $best_row[:key] = key
  $best_row[:high_outcomes] = value[:outcome_ratio]
  $best_row[:high_average] = value[:average]
end

result.each do |k,v|
  puts "#{k} : #{v}"
  if v[:outcome_ratio] > $best_row[:high_outcomes] then
    puts "#{v[:outcome_ratio]} is >= #{$best_row[:high_outcomes]}}"
    update_best_row(k,v)
  elsif v[:outcome_ratio] == $best_row[:high_outcomes] && v[:average] > $best_row[:high_average] then
    update_best_row(k,v)
  end
end
puts "The best choice is!!!! #{$best_row[:key]} with an outcome ratio of #{result[$best_row[:key]][:good_outcome]}:#{result[$best_row[:key]][:bad_outcome]} and average value of #{$best_row[:high_average]}"