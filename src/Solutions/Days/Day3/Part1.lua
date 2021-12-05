--[[
    Day 3 Part 1.

    Description / Preamble:
        Day 3 builds up two rates, a Gamma Rate and an Epsilon Rate, by calculating their values off a list of binary numbers.
        The values for each are defined as:
            Gamma Rate = More common bit in each position,
            Epsilon Rate = Less common bit in each position.
        
        For example, given three values:
            101,
            010,
            111,
        
        Then the gamma rate is 111 (because 1 is more common in each position), and the epsilon is 000 (because 0 is less common in each position).
    
    Task:
        Given the list of binary numbers, determine the epsilon and gamma rates, then multiply these together into a single value.
        
    Solution:
        We can store an array containing the counts at each position as we go through the list.
        At the end, we'll have the number of times that each occured, which will allow us to build out the Epsilon and Gamma Rate values.
    
    Running Time:
        This will require one pass through the entire list of values (O(n) time),
        Each step in the for loop takes constant time, because we're just doing some data manipulation (finding and incrementing a value),
        Once we have our positions calculated, we need one final pass through each bit to determine the values for Gamma and Epsilon (takes O(m) time, where m = # binary digits).
    
        So the running time of this solution is O(n + m)
]]
return function (input : string, helpers) : number
    -- Not implemented yet
    return -1
end