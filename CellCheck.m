% Row check
function [Problem, cellSolved, cellCheckHelped] = CellCheck(Problem, cellInd)
    cellSolved = 0;
    cellCheckHelped = 0;
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
    [cellIndices] = cellDefinitions(cellInd,find(Problem(cellDefinitions(cellInd,:)) == 0));
    if(~length(cellIndices)) cellSolved = 1; return; end
    [rowIndices colIndices] = ind2sub([9 9],cellIndices);
    newCell = cell(length(cellIndices),1);
    for i = 1 : length(cellIndices)
        [~,~,allValues,newCell{i,1}] = ComputePossibleValues(Problem, rowIndices(i), colIndices(i), cellInd);
    end
    allPossibleValues = zeros(length(allValues),1);
    for i = 1 : length(allValues)
        for j = 1 : length(cellIndices)
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
        for j = 1 : length(cellIndices)
            if(ismember(allValues(canBeAssigned(i)), newCell{j,1}))
                Problem(rowIndices(j),colIndices(j)) = allValues(canBeAssigned(i));
                fprintf('Assigned value %d to element [%d,%d]\n',allValues(canBeAssigned(i)),rowIndices(j),colIndices(j));
                cellCheckHelped = 1;
                break;
            end
        end
    end
end