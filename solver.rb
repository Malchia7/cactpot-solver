module CactpotSolver
  class Solver
    AllValues = [1,2,3,4,5,6,7,8,9]
    @@score_by_sum = {
        6 => 10000,
        7 => 36,
        8 => 720,
        9 => 360,
        10 => 80,
        11 => 252,
        12 => 108,
        13 => 72,
        14 => 54,
        15 => 180,
        16 => 72,
        17 => 180,
        18 => 119,
        19 => 36,
        20 => 306,
        21 => 1080,
        22 => 144,
        23 => 1800,
        24 => 3600
    }

    def initialize(known)
        @known = known
        @possible_values = AllValues - @known
    end

    def calculate_possible_outcomes(values)
        trimmed_values = values - [0]
        trimmed_sum = trimmed_values.sum
        number_of_zeros = 3 - trimmed_values.length
        result = {
            :bad_outcome => 0,
            :good_outcome => 0,
            :scores => {},
        }

        if number_of_zeros == 0 then
          sum = trimmed_sum
          score = @@score_by_sum[sum]
          result[:scores][sum] = score
          result[:average] = score
        end

        combinations = @possible_values.combination number_of_zeros
        if combinations.any? then
          combinations.each do |combo|
            sum = combo.sum + trimmed_sum
            score = @@score_by_sum[sum]
            result[:scores][sum] = score
          end
          result[:average] = result[:scores].values.sum / result[:scores].count
        end

        result[:scores].values.each do |score|
          if score > 180 then
            result[:good_outcome] += 1
          else
            result[:bad_outcome] += 1
          end
        end
        result[:outcome_ratio] = result[:good_outcome].to_f / (result[:bad_outcome] == 0 ? 1 : result[:bad_outcome])
        result
    end

    def calc_row1_across
        x1 = @known[0]
        x2 = @known[1]
        x3 = @known[2]
        calculate_possible_outcomes([x1,x2,x3])
    end

    def calc_row2_across
        x1 = @known[3]
        x2 = @known[4]
        x3 = @known[5]
        calculate_possible_outcomes([x1,x2,x3])
    end

    def calc_row3_across
        x1 = @known[6]
        x2 = @known[7]
        x3 = @known[8]
        calculate_possible_outcomes([x1,x2,x3])
    end

    def calc_diagonal_top_left
        x1 = @known[0]
        x2 = @known[4]
        x3 = @known[8]
        calculate_possible_outcomes([x1,x2,x3])
    end

    def calc_diagonal_top_right
        x1 = @known[2]
        x2 = @known[4]
        x3 = @known[6]
        calculate_possible_outcomes([x1,x2,x3])
    end

    def calc_column1_down
        x1 = @known[0]
        x2 = @known[3]
        x3 = @known[6]
        calculate_possible_outcomes([x1,x2,x3])
    end

    def calc_column2_down
        x1 = @known[1]
        x2 = @known[4]
        x3 = @known[7]
        calculate_possible_outcomes([x1,x2,x3])
    end

    def calc_column3_down
        x1 = @known[2]
        x2 = @known[5]
        x3 = @known[8]
        calculate_possible_outcomes([x1,x2,x3])
    end

    def calc_all
      {
        row1: calc_row1_across,
        row2: calc_row2_across,
        row3: calc_row3_across,
        topLeftDiag: calc_diagonal_top_left,
        column1: calc_column1_down,
        column2: calc_column2_down,
        column3: calc_column3_down,
        topRightDiag: calc_diagonal_top_right
      }
    end
  end
end