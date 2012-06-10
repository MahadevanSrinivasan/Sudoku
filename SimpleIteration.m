% SimpleIteration
function [Problem, problemSolved] = SimpleIteration(Problem)
    problemSolved = 0;
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
    [rowind colind] = find(Problem == 0);
    vectorIndex = find(Problem == 0);
    if(~length(vectorIndex))
        problemSolved = 1;
        return;
    end
    [rowind colind];

    for i = 1 : length(rowind)
        currRowInd = rowind(i);
        currColInd = colind(i);
        [cellInd, temp] = find(cellDefinitions == vectorIndex(i));
        cellDefinitions(cellInd,:);
        possibleRowValues = setdiff(allowedValues, Problem(currRowInd,:));
        possibleColValues = setdiff(allowedValues, Problem(:,currColInd));
        possibleCellValues = setdiff(allowedValues, Problem(cellDefinitions(cellInd,:)));
        possibleValues = intersect(possibleRowValues,possibleColValues);
        possibleValues = intersect(possibleValues,possibleCellValues);
        if(length(possibleValues) == 1)
            Problem(vectorIndex(i)) = possibleValues;
        end
    end
end