function Aggregated_cost = L_r(num_of_direcitons,cost_func,p_point,disparity,left_image,right_image)
%arguments: int, string, 1x2vector, int, matrix

switch num_of_directions
    case 1
        if cost_func == 'BT'
            Aggregated_cost = BT_cost()
        elseif cost_func == 'census'
        end
    case 2
        if cost_func == 'BT'
        elseif cost_func == 'census'
        end
    case 4
        if cost_func == 'BT'
        elseif cost_func == 'census'
        end
    case 8
        if cost_func == 'BT'
        elseif cost_func == 'census'
        end
                
    
end


end

