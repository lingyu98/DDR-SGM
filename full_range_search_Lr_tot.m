function Replaced_Lr_tot = full_range_search_Lr_tot(i,j,Lrl,Lrr,Lra,Lrb,left_img,right_img,win_size)
%输出计算了full d range cost map后所得Lr_tot向量
%return 分开的ij点的四路向量，到前面的函数里求和

DRANGE = 64;

radius = (win_size-1)/2;

p1 = 0.5;
p2 = 0.2;

cost_ijk = inf(1,1,DRANGE+1);


%disp('replacement')



max(i,j-DRANGE);

idx =  0;
for k = max(1,j-DRANGE):j

    idx = idx+1;
    left_point_p = [i+radius,j+radius];
    right_point_q = [i+radius,k+radius];

    %full range unaggregated census cost
    
    cost_ijk(1,1,idx) = census_cost(left_img,right_img,left_point_p,right_point_q,win_size);


%     now_vec9
%     now_vec3
%     now_vec0
%     now_vec6
%     
    
end

    
    
prev_vec9 = Lrl;
prev_min9 = min(prev_vec9);
now_vec9 = inf(1,1,DRANGE+1);
now_vec9(1) = cost_ijk(1,1,1)  + min([prev_vec9(1) prev_vec9(2)+p1 prev_min9+p2]) - prev_min9;
now_vec9(DRANGE+1) = cost_ijk(1,1,DRANGE+1) + min([prev_vec9(DRANGE+1) prev_vec9(DRANGE)+p1 prev_min9+p2]) - prev_min9;


prev_vec3 = Lrr;
prev_min3 = min(prev_vec3);
now_vec3 = inf(1,1,DRANGE+1);
now_vec3(1) = cost_ijk(1,1,1)  + min([prev_vec3(1) prev_vec3(2)+p1 prev_min3+p2]) - prev_min3;
now_vec3(DRANGE+1) = cost_ijk(1,1,DRANGE+1) + min([prev_vec3(DRANGE+1) prev_vec3(DRANGE)+p1 prev_min3+p2]) - prev_min3;


prev_vec0 = Lra;
prev_min0 = min(prev_vec0);
now_vec0 = inf(1,1,DRANGE+1);
now_vec0(1) = cost_ijk(1,1,1)  + min([prev_vec0(1) prev_vec0(2)+p1 prev_min3+p2]) - prev_min0;
now_vec0(DRANGE+1) = cost_ijk(1,1,DRANGE+1) + min([prev_vec0(DRANGE+1) prev_vec0(DRANGE)+p1 prev_min0+p2]) - prev_min0;

prev_vec6 = Lrb;
prev_min6 = min(prev_vec6);
now_vec6 = inf(1,1,DRANGE+1);
now_vec6(1) = cost_ijk(1,1,1)  + min([prev_vec6(1) prev_vec6(2)+p1 prev_min6+p2]) - prev_min6;
now_vec6(DRANGE+1) = cost_ijk(1,1,DRANGE+1) + min([prev_vec6(DRANGE+1) prev_vec6(DRANGE)+p1 prev_min6+p2]) - prev_min6;

for d = 2:DRANGE

    now_vec9(d) = cost_ijk(1,1,d) + min([prev_vec9(d) prev_vec9(d-1)+p1 prev_vec9(d+1)+p1 prev_min9+p2]) - prev_min9;
    now_vec3(d) = cost_ijk(1,1,d) + min([prev_vec3(d) prev_vec3(d-1)+p1 prev_vec3(d+1)+p1 prev_min3+p2]) - prev_min3;
    now_vec0(d) = cost_ijk(1,1,d) + min([prev_vec0(d) prev_vec0(d-1)+p1 prev_vec0(d+1)+p1 prev_min0+p2]) - prev_min0;
    now_vec6(d) = cost_ijk(1,1,d) + min([prev_vec6(d) prev_vec6(d-1)+p1 prev_vec6(d+1)+p1 prev_min6+p2]) - prev_min6;

end             

Replaced_Lr_tot = now_vec9 + now_vec3 + now_vec0 + now_vec6;

%Replaced_Lr_tot = 4*cost_ijk;

end

