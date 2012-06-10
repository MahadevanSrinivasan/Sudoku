function [currProgress, problemSolved] = EvaluatePerformance(Solution)
    problemSolved = 0;
    currProgress = prod(size(Solution))-nnz(Solution);
    if (currProgress == 0)
        problemSolved = 1;
    end
end