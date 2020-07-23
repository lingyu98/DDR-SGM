function [Cost_Map,Dis_Map] = compute_cost(base,cost,Left_image,Right_image,win_size)

[r,c] = size(Left_image);
radius = (win_size-1)/2;
Cost_Map = inf(r-2*radius,c-2*radius,c-2*radius);
Dis_Map = inf(r-2*radius,c-2*radius);

DRANGE = 64;

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
                        Dis_Map(i-radius,j-radius) = abs(j-k);                    

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
                        Dis_Map(i-radius,j-radius) = abs(j-k);                    

                    end

                end
            end
            %progress report, removable
            if mod(i,60) == 0
                disp((i/(r-2*radius))*100);
            end
        end
    end
%     for i = 1+radius:r-radius
%         for j = 1+radius:c-radius
%             min_cost = 9999;
%             for k = max(1+radius,j-DRANGE): min(j,c-radius)%Q of right image
%                 left_point_p = [i,j];
%                 right_point_q = [i,k];
%                 
%                 cost_ijk = BT_cost(Left_image,Right_image,left_point_p,right_point_q,win_size);
%                 Cost_Map(i-radius,j-radius,k-radius) = cost_ijk;
%                 if cost_ijk < min_cost
%                     min_cost = cost_ijk ;
%                     Dis_Map(i-radius,j-radius) = abs(j-k);                    
%                 end
%             %Cost_Map(i-radius,j-radius) = min_cost;
%             end  
%         end
%         if mod(i,20) == 0
%             disp((i/(r-2*radius))*100);
%         end  
%     end
   
    
elseif strcmp(cost,'census')==1 
     
    if strcmp(base,'l')==1 %use left image as basis
        
        for i = 1+radius:r-radius
            for j = 1+radius:c-radius
               % min_cost = 9999;
                for k = max(1+radius,j-DRANGE): j

                    left_point_p = [i,j];
                    right_point_q = [i,k];

                    %speed it up a bit
                    cost_ijk = census_cost(Left_image,Right_image,left_point_p,right_point_q,win_size);
                    Cost_Map(i-radius,j-radius,k-radius) = cost_ijk;

                    %without aggregation
%                     if cost_ijk < min_cost
%                         min_cost = cost_ijk ;
%                         Dis_Map(i-radius,j-radius) = j-k;  
% 
%                     end

                end
            end
            %progress report, removable
            if mod(i,20) == 0
                disp((i/(r-2*radius))*100);
            end
        end


%————————————————————————————————————————————————————————————————————
%         L_census = generate_census_map(Left_image,win_size);
%         disp('L done');
%         R_census = generate_census_map(Right_image,win_size);
%         disp('R done');
%         
%         for i = 1+radius:r-radius
%             for j = 1+radius:c-radius
%                % min_cost = 9999;
%                 for k = max(1+radius,j-DRANGE): j
% 
%                     %speed it up a bit
% 
%                     cost_ijk = Hamming_dis(L_census(i,j,:),R_census(i,k,:));
%                     Cost_Map(i-radius,j-radius,k-radius) = cost_ijk;
% 
%                 end
%             end
%             %progress report, removable
%             if mod(i,20) == 0
%                 disp((i/(r-2*radius))*100);
%             end
%         end
%————————————————————————————————————————————————————————————————————————    
        
        
        
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
                        Dis_Map(i-radius,j-radius) = abs(j-k);                    

                    end

                end
            end
            %progress report, removable
            if mod(i,20) == 0
                disp((i/(r-2*radius))*100);
            end
        end
    end
    
    
%------------------------------- trash -----------------------------
% using a census map:

%     L_census = generate_census_map(Left_image,win_size);
%     disp('L done');
%     R_census = generate_census_map(Right_image,win_size);
%     disp('R done');

%     for i = 1+radius:r-radius
%         for j = 1+radius:c-radius
%             min_cost = 9999;
%             for k = max(1+radius,j-DRANGE): min(j+64,c-radius)
%           
%                 cost_ijk = sum(xor(L_census(i,j,:),R_census(i,k,:)));
%                 Cost_Map(i-radius,j-radius,k-radius) = cost_ijk;
%                 
%                 if cost_ijk < min_cost
%                     min_cost = cost_ijk ;
%                     Dis_Map(i-radius,j-radius) = abs(k-j);
%                     
%                 end
%             %Cost_Map(i-radius,j-radius) = min_cost;
%             end
%         end
%         %progress report
%         disp((i/(r-2*radius))*100);
%     end
%------------------------------- trash -----------------------------

else
    disp('no such cost function');
    
end


end
