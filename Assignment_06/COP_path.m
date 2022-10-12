function [path_length] = COP_path(cop_x,cop_y)
%%COP_path - calculate the path length of the COP
%Input: 
% cop_x: x coordinates [m]. size = [length,1].
% cop_y: y coordinates [m]. size = [length,1].
%Output: 
% path_length: The whole path length of the COP [m]. size = [1,1].

%% Implementation
path_length = 0;
for i = 1:size(cop_x,1) - 1
    path_length = path_length + ...
                  sqrt((cop_x(i+1)-cop_x(i)).^2+(cop_y(i+1)-cop_y(i)).^2);
end

end