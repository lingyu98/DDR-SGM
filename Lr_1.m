function [Lr_cost_map] = Lr_1(base,C_map,p1,p2)
%3点钟方向聚合, Lr for a point, 输出向量，不同d下的cost
%basis,point to compute,disparity, cost map, coefficients p1 & p2

DRANGE = 64;
[r,c,depth] = size(C_map);

Lr_cost_map = inf(r,c,DRANGE+1);

%locate boudaries

if strcmp(base,'l')==1
    
    for i = 1:r%
        for j = c:-1:1+DRANGE%
            
            if i>c-j
                if j ==c
                    now_vec = C_map(i,j,j-DRANGE:j);
                    Lr_cost_map(i,j,:) = now_vec;
                    prev_vec = now_vec;
                else
                    prev_min = min(prev_vec);
                    now_vec = inf(1,1,DRANGE+1);
                    now_vec(1) = path_3(1,1,1) + min([prev_vec(1) prev_vec(2)+p1 prev_min+p2]) - prev_min;
                    now_vec(DRANGE+1) = path_3(1,1,DRANGE+1) + min([prev_vec(DRANGE+1) prev_vec(DRANGE)+p1 prev_min+p2]) - prev_min;
                    for d = 2:DRANGE
                        now_vec(d) = path_3(1,1,d) + min([prev_vec(d) prev_vec(d-1)+p1 prev_vec(d+1)+p1 prev_min+p2]) - prev_min;%Lr3(i,j,64-d)
                    end             

                    Lr_cost_map(i,j,:) = now_vec;
                    prev_vec = now_vec;
                    
                end
                
                
            else
                
                
                
            end
            
            if j == c %
                now_vec = path_3(1,1,:); % a costvector with length of disparity range (64)

                Lr_cost_map(i,j,:) = now_vec;
                prev_vec = now_vec;
            else
                 %Iy = orgimage(i,j);
                 %I_prev = orgimage()%
                %disp('第二个像素：');
                prev_min = min(prev_vec);
                now_vec = inf(1,1,DRANGE+1);
                now_vec(1) = path_3(1,1,1) + min([prev_vec(1) prev_vec(2)+p1 prev_min+p2]) - prev_min;
                now_vec(DRANGE+1) = path_3(1,1,DRANGE+1) + min([prev_vec(DRANGE+1) prev_vec(DRANGE)+p1 prev_min+p2]) - prev_min;
                for d = 2:DRANGE
                    now_vec(d) = path_3(1,1,d) + min([prev_vec(d) prev_vec(d-1)+p1 prev_vec(d+1)+p1 prev_min+p2]) - prev_min;%Lr3(i,j,64-d)
                end             

                Lr_cost_map(i,j,:) = now_vec;
                prev_vec = now_vec;
            end
        end
              
        
        
        
        
        
        
        %progress report, removable
        if mod(i,150) == 0
            disp('path3:');
            disp((i/r)*100);
        end
    end

    
%elseif strcmp(base,'r')==1
    
    
    
end


end
