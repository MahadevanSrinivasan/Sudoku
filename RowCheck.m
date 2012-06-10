% Row check
function [Problem, rowSolved, rowCheckHelped] = RowCheck(Problem, rowInd)
    rowSolved = 0;
    rowCheckHelped = 0;
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
    [colIndices] = find(Problem(rowInd,:) == 0);
    if(~length(colIndices)) rowSolved = 1; return; end
    newCell = cell(length(colIndices),1);
    for i = 1 : length(colIndices)
        vectorIndex = sub2ind([9 9],rowInd,colIndices(i));
        [cellInd, ~] = find(cellDefinitions == vectorIndex);
        [allValues,~,~,newCell{i,1}] = ComputePossibleValues(Problem, rowInd, colIndices(i), cellInd);
    end
    allPossibleValues = zeros(length(allValues),1);
    for i = 1 : length(allValues)
        for j = 1 : length(colIndices)
            if(ismember(allValues(i), newCell{j,1}))
                allPossibleValues(i) = allPossibleValues(i) + 1;
            end
        end
    end
    newCell
    allValues
    allPossibleValues'
    canBeAssigned = find(allPossibleValues == 1);
    for i = 1 : length(canBeAssigned)
        for j = 1 : length(colIndices)
            if(ismember(allValues(canBeAssigned(i)), newCell{j,1}))
                Problem(rowInd,colIndices(j)) = allValues(canBeAssigned(i));
                fprintf('Assigned value %d to element [%d,%d]\n',allValues(canBeAssigned(i)),rowInd,colIndices(j));
                rowCheckHelped = 1;
                break;
            end
        end
    end
end