function [Cost_Map] = DDR_compute_cost(base,cost,prev_dis_map,Left_image,Right_image,win_size,DRANGE,RRANGE)

[r,c] = size(Left_image);
radius = (win_size-1)/2;
Cost_Map = inf(r-2*radius,c-2*radius,c-2*radius);

if strcmp(cost,'BT')==1
         
    if strcmp(base,'l')==1 %use left image as basis
        for i = 1+radius:r-radius
            for j = 1+radius:c-radius
                min_cost = 9999;
                for k = max(1+radius,j-DRANGE): min(j,c-radius)

                    left_point_p = [i,j];
                    right_point_q = [i,k];

                    %speed it up a bit
                    cost_ijk = BT_cost(Left_image,Right_image,left_point_p,right_point_q,win_size);
                    Cost_Map(i-radius,j-radius,k-radius) = cost_ijk;

                    if cost_ijk < min_cost
                        min_cost = cost_ijk ;                

                    end

                end
            end
            %progress report, removable
            if mod(i,20) == 0
                disp((i/(r-2*radius))*100);
            end
        end
        
    elseif strcmp(base,'r')==1 %use right image as basis
        for i = 1+radius:r-radius
            for j = 1+radius:c-radius
                min_cost = 9999;
                for k = max(1+radius,j): min(j+DRANGE,c-radius)

                    left_point_p = [i,j];
                    right_point_q = [i,k];

                    %speed it up a bit
                    cost_ijk = BT_cost(Left_image,Right_image,left_point_p,right_point_q,win_size);
                    Cost_Map(i-radius,j-radius,k-radius) = cost_ijk;

                    if cost_ijk < min_cost
                        min_cost = cost_ijk ;                   

                    end

                end
            end
            %progress report, removable
            if mod(i,60) == 0
                disp((i/(r-2*radius))*100);
            end
        end
    end
    

 %-------------------------------essiential!------------------------------------    
 
elseif strcmp(cost,'census')==1 
     
    if strcmp(base,'l')==1 %use left image as basis
        for i = 1+radius:r-radius
            for j = 1+radius:c-radius
                %DDR:
                d_ij = prev_dis_map(i-radius,j-radius);%根据上一副dis map给出的建议d值
                for k = max([1+radius,j-DRANGE,j-d_ij-RRANGE]): min(j,j-d_ij+RRANGE)

                    left_point_p = [i,j];
                    right_point_q = [i,k];

                    %speed it up a bit
                    cost_ijk = census_cost(Left_image,Right_image,left_point_p,right_point_q,win_size);
                    Cost_Map(i-radius,j-radius,k-radius) = cost_ijk;

                end
            end
            %progress report, removable
            if mod(i,60) == 0
                disp((i/(r-2*radius))*100);
            end
        end
 %-------------------------------essiential!------------------------------------
 
 
 
 
    elseif strcmp(base,'r')==1 %use right image as basis
        for i = 1+radius:r-radius
            for j = 1+radius:c-radius
                min_cost = 9999;
                for k = j: min(j+DRANGE,c-radius)

                    left_point_p = [i,j];
                    right_point_q = [i,k];

                    %speed it up a bit
                    cost_ijk = census_cost(Left_image,Right_image,left_point_p,right_point_q,win_size);
                    Cost_Map(i-radius,j-radius,k-radius) = cost_ijk;

                    if cost_ijk < min_cost
                        min_cost = cost_ijk ;             

                    end

                end
            end
            %progress report, removable
            if mod(i,20) == 0
                disp((i/(r-2*radius))*100);
            end
        end
    end
    

else
    disp('no such cost function');
    
end


end