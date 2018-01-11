class DynamicProgramming

  def initialize
    @blair_cache = {1 => 1, 2 => 2} #3: 1 <k-2> + 2 <k-1> + ((k-1) * 2 - 1)
    @frog_hops_cache = {1 => [[1]],
                        2 => [[1, 1], [2]],
                        3 => [[1,1,1], [1,2], [2,1], [3]]}
    @maze_solver_cache = {} #bonus
  end

  def blair_nums(n)
    # #bottom-up
    # return blair_cache_builder(n)[n]
    #top-down
    ans = @blair_cache[n]
    return ans if ans

    @blair_cache[n] = blair_nums(n-2) + blair_nums(n-1) + 2 * n - 3
  end

  def blair_cache_builder(n)
    cache = @blair_cache
    return cache if n < 3

    (3..n).each do |num|
      cache[num] = cache[num-2] + cache[num-1] + 2 * num - 3
    end

    cache
  end

  def frog_hops_bottom_up(n)
    cache = { 1 => [[1]],
              2 => [[1, 1], [2]],
              3 => [[1,1,1], [1,2], [2,1], [3]] }

    ans = cache[n]
    return ans if ans

    (4..n).each do |num|
      cache_minus_1 = cache[num-1].map {|arr| arr + [1]}
      cache_minus_2 = cache[num-2].map {|arr| arr + [2]}
      cache_minus_3 = cache[num-3].map {|arr| arr + [3]}
      cache[num] = cache_minus_1 + cache_minus_2 + cache_minus_3
    end

    cache[n]
  end

  def frog_cache_builder(n)
    cache = { 1 => [[1]],
              2 => [[1, 1], [2]],
              3 => [[1,1,1], [1,2], [2,1], [3]] }

    ans = cache[n]
    return ans if ans

    frog_hops_bottom_up(n)
  end

  def frog_hops_top_down(n)
    ans = @frog_hops_cache[n]
    return ans if ans

    ans = frog_hops_top_down(n-3).map{|arr| arr + [3]} +
          frog_hops_top_down(n-2).map{|arr| arr + [2]} +
          frog_hops_top_down(n-1).map{|arr| arr + [1]}

    @frog_hops_cache[n] = ans
  end

  # def frog_hops_top_down_helper(n) #not sure why the need...
  #   return @frog_hops_cache[n] if @frog_hops_cache[n]
  #
  #   cache_minus_1 = @frog_hops_cache[n-1]
  #   cache_minus_2 = @frog_hops_cache[n-2]
  #   cache_minus_3 = @frog_hops_cache[n-3]
  #
  #   if cache_minus_3
  #     cache_minus_3 = cache_minus_3.map{|arr| arr + [3]}
  #   else
  #     frog_hops_top_down_helper(n-3)
  #   end
  #
  #   if cache_minus_2
  #     cache_minus_2 = cache_minus_2.map{|arr| arr + [2]}
  #   else
  #     frog_hops_top_down_helper(n-2)
  #   end
  #
  #   if cache_minus_1
  #     cache_minus_1 = cache_minus_1.map{|arr| arr + [1]}
  #   else
  #     frog_hops_top_down_helper(n-1)
  #   end
  #
  #   cache_minus_3 + cache_minus_2 + cache_minus_1
  # end

  def super_frog_hops(n, k) #num_stairs, biggest_jump
    return @frog_hops_cache[n] if n < 4 && k >= 3

    if k == 1
      @frog_hops_cache[2] = [[1,1]]
      @frog_hops_cache[3] = [[1,1,1]]
    else
      @frog_hops_cache[2] = [[1,1], [2]]
      @frog_hops_cache[3] = [[1,1,1], [1,2], [2,1], [3]] if k > 2
      @frog_hops_cache[3] = [[1,1,1], [1,2], [2,1]] if k == 2
    end
    return @frog_hops_cache[n] if @frog_hops_cache[n]

    if k >= n
      cache = []
      (1...n).each do |num|
        cache.concat( super_frog_hops(n - num, k).map{|arr| arr + [num]} )
      end
      cache << [n]
      @frog_hops_cache[n] = cache
    else #k < n
      super_frog_hops(k, k)

      (k+1..n).each do |number|
        cache = []
        (1..k).each do |num|
          cache.concat( super_frog_hops(number - num, k).map{|arr| arr + [num]} )
        end

        @frog_hops_cache[number] = cache
      end
    end

    @frog_hops_cache[n]
  end

  def knapsack(weights, values, capacity) #can try summing weights, then values; store if > max value
    @knapsack = {}
    #First, store weight-value pairs
    weights.each_index do |idx|
      @knapsack[weights[idx]] = values[idx]  #{1: 10, 2: 4, 3: 8}
    end

    weight_keys = weights.sort
    return 0 if capacity < weight_keys[0]  #6 < 1 => false
    return @knapsack[weight_keys[0]] if capacity == weight_keys[0]

    @max_weights = []
    @max_values = []

    weight_keys.each_index do |i|
      current_weight = weight_keys[i]
      current_value = @knapsack[current_weight]
      if @max_weights.empty?
        @max_weights.push(current_weight)
        @max_values.push([ current_value ])
      else
        @max_weights.each_index do |j|
          new_weight = @max_weights[j] + current_weight
          if new_weight <= capacity &&
               @max_values[j].inject(:+) + current_value >
                 @max_values[-1].inject(:+) &&
               !@max_values[j].include?(current_value)
            @max_weights.push(new_weight)
            @max_values.push(@max_values[j].dup << current_value)
          end
        end
      end
    end

    sum = @max_values[-1].inject(:+)
    sum
  end #Time: O(n^2)

  # v----- GOT too complex -----v
  #works w/ the exception of case where if 1 weight's value > the sum of 2 weight's values
  #so each time, I need to sum @capacity_cache[weight] from bottom to top,
    #do my test to see if there's a greater sum, and assign accordingly

  #C = 23 #W = [23, 31, 29, 44, 53, 38, 63, 85, 89, 82 ]  #53 is replacing 31
          #V = [ 92, 57, 49, 68, 60, 43, 67, 84, 87, 72 ]
  def knapsack0(weights, values, capacity) #C = 6 #W = [1,2,3] #V = [10, 4, 8]--equal-sized
    @knapsack = {}
    @capacity_cache = {}
    @value_cache = {}
    #First, store & cache weight-value pairs
    weights.each_index do |idx|
      @knapsack[weights[idx]] = values[idx]  #{1: 10, 2: 4, 3: 8}
      @capacity_cache[weights[idx]] = [ values[idx] ]  #{1: [10], 2: [4], 3: [8]}
      @value_cache[values[idx]] = [ weights[idx] ]  #{10: [1], 4: [2], 8: [3]}
    end

    weight_keys = weights.sort  #[1,2,3] #[23...]
    @min = weight_keys[0]
    #Check if any valid weights
    return 0 if capacity < @min  #6 < 1 => false
    return @capacity_cache[@min].first if capacity == @min

    #set base case; value keyed to weights array  # 10: [1]  #92: [23]
    latest_value = @knapsack[@min]
    latest_weights = @value_cache[latest_value].dup
    #Combine valid weights' values w/ cached weight-value sets
    #Cache highest value set to current weight
    (@min + 1..capacity).each do |weight|  #2 | 3 | 4 | 5 | 6
      #select possible keys
      valid_keys = weight_keys.select{|key| key <= weight && !latest_weights.include?(key)}  #[1,2] | [1,2,3]

      (0...valid_keys.length).each do |i|  #0 |, 1

        current_value_set = @capacity_cache[@min]
        (@min + 1..weight).each do |cap_weight|

          new_weight = valid_keys[i] + latest_weights.inject(:+)  #2+1= 3|, 3+1+2= 6 |,|2+1+3= 6
          #can either:
          #Add a weight to the set,
          if new_weight <= weight  #3 <= 2 => false | #3 <= 3 => true, 6 <= 3 => false ||| 6 <= 6 => true
            #set new value to weights array
            latest_sum = 0
            latest_weights.each {|wt| latest_sum += @knapsack[wt]}  #=> 10 |||| 10+8
            latest_value = @knapsack[valid_keys[i]] + latest_sum  #| 10+4= 14 ||| +4= 22
            @value_cache[latest_value] = latest_weights << valid_keys[i]  #| 14: [1,2] ||| 22: [1,3,2]
            latest_weights = @value_cache[latest_value]  #[1] | [1,2] | [1,3,2]
          #Replace a weight from the set,
          else
            smallest = @knapsack[valid_keys[i]]  #4 |. 8
            weight_of_smallest = valid_keys[i]  #2 |. 3
            latest_weights.each do |wt|
              #10 < 4 => false |. 10 < 8 => false, 4 < 8 but 1+3 <= 3 => false |
                #1+3 <= 4 => true |. 8 < 4 => false
              if @knapsack[wt] < smallest && #one weight's value is less
                   latest_weights.inject(:+) - wt + valid_keys[i] <= capacity
                   #and replacing it w/ new weight would be valid
                smallest = @knapsack[wt]  #||4
                weight_of_smallest = wt  #||2
              end
            end

            #or Do nothing
            if smallest != @knapsack[valid_keys[i]]  #false |. false | true | false
              latest_weights.delete(weight_of_smallest)
              latest_weights.push(valid_keys[i])  #||[1,3]
              latest_value = latest_value - smallest + @knapsack[valid_keys[i]]  #||14-4+8= 18
              @value_cache[latest_value] = latest_weights  #18: [1,3]
            end
          end
        end
      end

      capacity_array = []   #[1] | [1,2] | [1,3] || [1,3,2]
      @value_cache[latest_value].each{ |wt| capacity_array.push(@knapsack[wt]) }
      @capacity_cache[weight] = capacity_array  #2: [10] | 3: [10,4] | 4: [10, 8] | 5: [10, 8] | 6: [10, 8, 4]
    end
    p '----'
    p @capacity_cache[capacity]
    sum = @capacity_cache[capacity].inject(:+)  #22
    sum
  end

  # Helper method for bottom-up implementation
  def knapsack_table(weights, values, capacity)

  end

  def maze_solver(maze, start_pos, end_pos)
  end
end
