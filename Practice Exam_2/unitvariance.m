function [ vector_unit ] = unitvariance( vector )
%UNITVARIANCE Normalises input vector to unit variance

vector_unit = vector/std(vector);

end

