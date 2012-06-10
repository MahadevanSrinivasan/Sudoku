% CheckSolved
function [isDone] = CheckSolved(Solution, problemSolved)
    isDone = 0;
    if(problemSolved)
        disp('Problem Solved');
        Solution
        isDone = 1;
    end
end