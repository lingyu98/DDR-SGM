function [Lr_cost_map] = Lr_0(base,C_map,p1,p2)
%0,6点钟方向聚合, Lr for a point, 输出向量，不同d下的cost
%basis,point to compute,disparity, cost map, coefficients p1 & p2

DRANGE = 64;
[r,c,depth] = size(C_map);

Lr_cost_map = inf(r,c,DRANGE+1);

if strcmp(base,'l')==1
    
    for j = 1+DRANGE:c%


        for i = 1:r%
            path_0 = C_map(1:i,j,j-DRANGE:j);%右往左
            if i == 1 %
                
                now_vec = path_0(end,1,:);
                Lr_cost_map(i,j,:) = now_vec;
                
                prev_vec = now_vec;
            else

                prev_min = min(prev_vec);
                now_vec = inf(1,1,DRANGE+1);
                now_vec(1) = path_0(end,1,1) + min([prev_vec(1) prev_vec(2)+p1 prev_min+p2]) - prev_min;
                now_vec(DRANGE+1) = path_0(end,1,DRANGE+1) + min([prev_vec(DRANGE+1) prev_vec(DRANGE)+p1 prev_min+p2]) - prev_min;
                for d = 2:DRANGE
                    now_vec(d) = path_0(end,1,d) + min([prev_vec(d) prev_vec(d-1)+p1 prev_vec(d+1)+p1 prev_min+p2]) - prev_min;%Lr3(i,j,64-d)
                end             

                Lr_cost_map(i,j,:) = now_vec ;

                prev_vec = now_vec;
            end
        end
        
        
        %progress report, removable
        if mod(j,150) == 0
            disp('path0');
            disp((j/r)*100);
        end
    end

    
%elseif strcmp(base,'r')==1
    
    
    
end


end