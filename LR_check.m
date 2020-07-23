function checked_map = LR_check(Dis_map_1,Dis_map_2)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

[r, c] = size(Dis_map_1);
checked_map = Dis_map_1;


for i = 1:r
    for j = 1:c
        if abs(Dis_map_1(i,j)-Dis_map_2(i,j))>1
            checked_map(i,j) = inf;
        end
    end
end


end

