function [Lr_cost_map] = Lr_t(base,isfrstfrm,C_map,prev_Lr_map,p1,p2)
%3,9点钟方向聚合, Lr for a point, 输出向量，不同d下的cost
%basis,point to compute,disparity, cost map, coefficients p1 & p2

DRANGE = 64;
[r,c,depth] = size(C_map);

Lr_cost_map = inf(r,c,DRANGE+1);

if strcmp(base,'l')==1
    
    for i = 1:r%
        for j = 1+DRANGE:c%
            %path_t = C_map(i,j:c,j-DRANGE:j);
            if isfrstfrm == 1 %
                now_ij = C_map(i,j,j-DRANGE:j); 
                Lr_cost_map(i,j,:) = now_ij;
            else
                prev_vec = prev_Lr_map(i,j,:);
                prev_min = min(prev_vec);
                cost_ij = C_map(i,j,j-DRANGE:j); 
                
                now_ij = inf(1,1,DRANGE+1);
                now_ij(1) = cost_ij(1,1,1) + min([prev_vec(1) prev_vec(2)+p1 prev_min+p2]) - prev_min;
                now_ij(DRANGE+1) = cost_ij(1,1,DRANGE+1) + min([prev_vec(DRANGE+1) prev_vec(DRANGE)+p1 prev_min+p2]) - prev_min;
                for d = 2:DRANGE
                    now_ij(d) = cost_ij(1,1,d) + min([prev_vec(d) prev_vec(d-1)+p1 prev_vec(d+1)+p1 prev_min+p2]) - prev_min;
                end             

                Lr_cost_map(i,j,:) = now_ij;
            end
        end
              
        %progress report, removable
        if mod(i,150) == 0
            disp('patht:');
            disp((i/r)*100);
        end
    end

    
%elseif strcmp(base,'r')==1
    
    
    
end


end