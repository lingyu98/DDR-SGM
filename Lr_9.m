function [Lr_cost_map] = Lr_9(base,C_map,p1,p2)
%3,9点钟方向聚合, Lr for a point, 输出向量，不同d下的cost
%basis,point to compute,disparity, cost map, coefficients p1 & p2

DRANGE = 64;
[r,c,depth] = size(C_map);

Lr_cost_map = inf(r,c,DRANGE+1);

if strcmp(base,'l')==1
    
    for i = 1:r%

        for j = 1+DRANGE:c%
            path_9 = C_map(i,1:j,j-DRANGE:j);%右往左
            if j == 1+DRANGE %
                
                now_vec = path_9(1,end,:);

                Lr_cost_map(i,j,:) = now_vec;
                prev_vec = now_vec;
            else
                 %Iy = orgimage(i,j);
                 %I_prev = orgimage()%
                %disp('第二个像素：');
                prev_min = min(prev_vec);
                now_vec = inf(1,1,DRANGE+1);
                now_vec(1) = path_9(1,end,1) + min([prev_vec(1) prev_vec(2)+p1 prev_min+p2]) - prev_min;
                now_vec(DRANGE+1) = path_9(1,end,DRANGE+1) + min([prev_vec(DRANGE+1) prev_vec(DRANGE)+p1 prev_min+p2]) - prev_min;
                for d = 2:DRANGE
                    now_vec(d) = path_9(1,end,d) + min([prev_vec(d) prev_vec(d-1)+p1 prev_vec(d+1)+p1 prev_min+p2]) - prev_min;%Lr3(i,j,64-d)
                end             

                Lr_cost_map(i,j,:) = now_vec;
                prev_vec = now_vec;
            end
        end
        
        
        %progress report, removable
        if mod(i,150) == 0
            disp('path9');
            disp((i/r)*100);
        end
    end

    
%elseif strcmp(base,'r')==1
    
    
    
end


end
