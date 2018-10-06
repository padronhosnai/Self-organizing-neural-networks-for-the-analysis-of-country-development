function vectorNormalized = normalisation_minmax(matrix)
%NORMALISATION_MINMAX Summary of this function goes here
%   Detailed explanation goes here

    numRows = size(matrix,1);
    numCols = size(matrix,2);
    vectorNormalized = zeros(numRows,numCols);
    
    for i = 1:numRows
        vector = matrix(i,:);
        
        mini = min(vector);
        maxi = max(vector);
        vectorNormalized(i,:) = (vector - mini)/(maxi-mini);
    end
end

