function [ angle ] = angle3d( v1,v2)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

dotproduct = dot(v1,v2,2);
normproduct = norm(v1)*norm(v2);
angle = acosd(dotproduct/normproduct);

end

