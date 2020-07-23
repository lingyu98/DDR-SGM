function [Lr_cost_map] = Lr_6(base,C_map,p1,p2)
%0,6点钟方向聚合, Lr for a point, 输出向量，不同d下的cost
%basis,point to compute,disparity, cost map, coefficients p1 & p2

DRANGE = 64;
[r,c,depth] = size(C_map);

Lr_cost_map = inf(r,c,DRANGE+1);

if strcmp(base,'l')==1
    
    for j = 1+DRANGE:c%

        for i = r:-1:1%
            path_6 = C_map(i:r,j,j-DRANGE:j);
            if i == r %
                now_vec = path_6(1,1,:); % a costvector with length of disparity range (64)

                Lr_cost_map(i,j,:) = now_vec;
                prev_vec = now_vec;
            else

                prev_min = min(prev_vec);
                now_vec = inf(1,DRANGE+1);
                now_vec(1) = path_6(1,1,1) + min([prev_vec(1) prev_vec(2)+p1 prev_min+p2]) - prev_min;
                now_vec(DRANGE+1) = path_6(1,1,DRANGE+1) + min([prev_vec(DRANGE+1) prev_vec(DRANGE)+p1 prev_min+p2]) - prev_min;
                for d = 2:DRANGE
                    now_vec(d) = path_6(1,1,d) + min([prev_vec(d) prev_vec(d-1)+p1 prev_vec(d+1)+p1 prev_min+p2]) - prev_min;%Lr3(i,j,64-d)
                end             

                Lr_cost_map(i,j,:) = now_vec;
                prev_vec = now_vec;
            end
        end
        
        
        %progress report, removable
        if mod(j,150) == 0
            disp('path6');
            disp((j/r)*100);
        end
    end

    
%elseif strcmp(base,'r')==1
    
    
    
end


end