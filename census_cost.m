function censuscost = census_cost(Left_img,Right_img,P,Q,win_size)

P_x = P(1);
P_y = P(2);
Q_x = Q(1);
Q_y = Q(2);
r = (win_size-1)/2;
P_neighbors = Left_img(P_x-r:P_x+r,P_y-r:P_y+r);
Q_neighbors = Right_img(Q_x-r:Q_x+r,Q_y-r:Q_y+r);

L_center = Left_img(P_x,P_y);
R_center = Right_img(Q_x,Q_y);

%How about:
sum = 0;

for m = 1:win_size
    for n = 1:win_size
        if (Q_neighbors(m,n) <= R_center && P_neighbors(m,n) <= L_center) || (Q_neighbors(m,n) > R_center && P_neighbors(m,n) > L_center)

        else
            sum = sum + 1;
        end
    end
end

censuscost = sum/(win_size*win_size);


%------------------------------- trash -----------------------------
%Too slow for me


% P_vector = zeros(win_size*win_size,1);
% 
% for i = 1:win_size
%     for j = 1:win_size
%         if P_neighbors(i,j) <= P_neighbors(r+1,r+1)
%             P_vector((i-1)*win_size+j) = 0;
%         else
%             P_vector((i-1)*win_size+j) = 1;
%         end
%     end
% end
%       
% Q_vector = zeros(win_size*win_size,1);
% 
% for m = 1:win_size
%     for n = 1:win_size
%         if Q_neighbors(m,n) <= Q_neighbors(r+1,r+1)
%             Q_vector((m-1)*win_size+n) = 0;
%         else
%             Q_vector((m-1)*win_size+n) = 1;
%         end
%     end
% end
% 
% %Hamming
% 
% censuscost = sum(xor(P_vector,Q_vector));
%------------------------------- trash -----------------------------

end

