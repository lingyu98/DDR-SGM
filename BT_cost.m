function btcost = BT_cost(Left_img,Right_img,P,Q,win_size)

P_x = P(1);
P_y = P(2);
Q_x = Q(1);
Q_y = Q(2);
r = (win_size-1)/2;
P_neighbors = Left_img(P_x-r:P_x+r,P_y-r:P_y+r);
Q_neighbors = Right_img(Q_x-r:Q_x+r,Q_y-r:Q_y+r);

L_center = Left_img(P_x,P_y);
R_center = Right_img(Q_x,Q_y);


Min_Q = min(Q_neighbors(:));
Max_Q = max(Q_neighbors(:));

if (Min_Q <= L_center) && (L_center <= Max_Q)
    cost1 = 0;
else
    cost1 = min([abs(L_center-Max_Q) abs(L_center-Min_Q)]);
end
    


Min_P = min(P_neighbors(:));
Max_P = max(P_neighbors(:));

if (Min_P <= R_center) && (R_center <= Max_P)
    cost2 = 0;
else
    cost2 = min([abs(R_center-Max_P) abs(R_center-Min_P)]);
end

btcost = (cost1+cost2)/2;

end


