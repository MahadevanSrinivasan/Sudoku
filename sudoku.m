% Sudoku Solver
% Attempt 1 - Simple solver
function sudoku()

maxIter = 10;
problemSolved = 0;
%Easy Problem
% Problem = [0 0 1 0 0 2 4 6 0; ...
           % 6 0 0 0 0 0 0 5 0; ...
           % 0 9 8 4 0 0 0 0 0; ...
           % 4 6 0 5 9 0 3 0 8; ...
           % 0 0 7 1 2 4 5 0 0; ...
           % 9 0 5 0 6 3 0 4 7; ...
           % 0 0 0 0 0 8 6 3 0; ...
           % 0 3 0 0 0 0 0 0 4; ...
           % 0 5 4 6 0 0 7 0 0]
%Medium Problem
% Problem = [0 0 0 1 0 0 9 2 0; ...
           % 0 9 0 0 4 6 0 0 0; ...
           % 0 0 0 0 5 0 4 0 0; ...
           % 5 0 0 0 0 9 0 0 2; ...
           % 8 0 6 4 2 1 3 0 9; ...
           % 3 0 0 8 0 0 0 0 1; ...
           % 0 0 4 0 1 0 0 0 0; ...
           % 0 0 0 5 7 0 0 1 0; ...
           % 0 8 5 0 0 3 0 0 0]
%Difficult Problem    
Problem = [8 0 1 5 0 0 0 0 0; ...
           0 9 0 0 0 0 0 8 0; ...
           0 0 0 0 0 0 0 1 4; ...
           7 1 0 0 0 0 0 2 0; ...
           0 0 3 0 6 7 1 9 0; ...
           0 0 9 0 1 0 7 4 3; ...
           0 0 0 1 7 4 0 0 9; ...
           1 0 4 0 0 0 8 0 0; ...
           9 5 0 0 3 0 4 0 1]
           
Solution = Problem;
[prevProgress, problemSolved] = EvaluatePerformance(Solution);
fprintf('Number of empty elements = %d\n',prevProgress);

cellDefinitions = [1:3,10:12,19:21; ...
                   28:30,37:39,46:48; ...
                   55:57,64:66,73:75; ...
                   4:6,13:15,22:24; ...
                   31:33,40:42,49:51; ...
                   58:60,67:69,76:78; ...
                   7:9,16:18,25:27; ...
                   34:36,43:45,52:54; ...
                   61:63,70:72,79:81];

allowedValues = 1:9;
% Loop through all non-zero elements and find the obvious based on rows and columns

    for iter = 1 : maxIter
        fprintf('Iteration: %d\n',iter);
        [Solution, problemSolved] = SimpleIteration(Solution);
        isDone = CheckSolved(Solution, problemSolved);
        [currProgress, problemSolved] = EvaluatePerformance(Solution);
        if(currProgress == prevProgress)
            disp('Simple searching done...');
            break;
        end
        prevProgress = currProgress;
    end
    Solution
    pause;
    for iter = 1 : 1%maxIter
        allRowSolved = 0; allColSolved = 0; allCellSolved = 0;
        if(~isDone)
            disp('Problem is not simple, Next Level Check!');
            for i = 1 : 9
                fprintf('Checking row %d\n',i);
                [Solution, rowSolved, rowCheckHelped] = RowCheck(Solution, i);
                
                if(rowCheckHelped)
                    [Solution, problemSolved] = SimpleIteration(Solution);
                end
                allRowSolved = allRowSolved + rowSolved;
                if (allRowSolved == 9) problemSolved = 1; end
                isDone = CheckSolved(Solution, problemSolved);
                if(isDone) break; end
                % pause;
            end
            pause;
            [currProgress, problemSolved] = EvaluatePerformance(Solution);
            fprintf('Number of empty elements after Row Check = %d\n',currProgress);
            if(~isDone)
                for i = 1 : 9
                    fprintf('Checking column %d\n',i);
                    [Solution, colSolved, colCheckHelped] = ColumnCheck(Solution, i);
                    
                    if(colCheckHelped)
                        [Solution, problemSolved] = SimpleIteration(Solution);
                    end
                    allColSolved = allColSolved + colSolved;
                    if (allColSolved == 9) problemSolved = 1; end
                    isDone = CheckSolved(Solution, problemSolved);
                    if(isDone) break; end
                    % pause;
                end
                pause;
                [currProgress, problemSolved] = EvaluatePerformance(Solution);
                fprintf('Number of empty elements after Column Check = %d\n',currProgress);
                if(~isDone)
                    for i = 1 : 9
                        fprintf('Checking cell %d\n',i);
                        [Solution, cellSolved, cellCheckHelped] = CellCheck(Solution, i);
                        
                        if(cellCheckHelped)
                            [Solution, problemSolved] = SimpleIteration(Solution);
                        end
                        allCellSolved = allCellSolved + cellSolved;
                        if (allCellSolved == 9) problemSolved = 1; end
                        isDone = CheckSolved(Solution, problemSolved);
                        if(isDone) break; end
                        pause;
                    end
                    pause;
                    [currProgress, problemSolved] = EvaluatePerformance(Solution);
                    fprintf('Number of empty elements after Cell Check = %d\n',currProgress);
                end
            end
        end
    end
    [Solution, problemSolved] = SimpleIteration(Solution);
    Solution
end