clc
clear


tic

RES = 1;
WINDOW_SIZE = 11;
FIRST_FRAME = 1;
LAST_FRAME = 15;
D_RANGE = 64;
R_RANGE = 10;
THRESHOLD = 1.7;
p1 = 0.6;
p2 = 2.5;

p1_t = 0.6;
p2_t = 2.5;

[L_mat, R_mat] = Load_images(FIRST_FRAME,LAST_FRAME,RES);


% First Frame 普通SGM单独计算
[co_1,dis_no_use] = compute_cost('l','census',L_mat(:,:,FIRST_FRAME),R_mat(:,:,FIRST_FRAME),WINDOW_SIZE);%bases,cost,input l,input r,size of window
disp('cmap_1 computation done')


Lrt1 = Lr_t('l',1,co_1,0,p1_t,p2_t);
[dis_1,Lr_tot_1]= Lr_total('l',0,THRESHOLD,Lr_9('l',co_1,p1,p2),Lr_3('l',co_1,p1,p2),Lr_0('l',co_1,p1,p2),Lr_6('l',co_1,p1,p2),Lrt1,L_mat(:,:,1),R_mat(:,:,1),WINDOW_SIZE);

[Map_r, Map_c] = size(dis_1);

%dismap，第三个维度是时间
DDR_Dis_Map = inf(Map_r, Map_c,LAST_FRAME-FIRST_FRAME+1);
DDR_Dis_Map(:,:,1) = dis_1;


prev_dis = dis_1;
Lr_prev = Lr_tot_1;



for i = FIRST_FRAME+1:LAST_FRAME
    
    disp('frame');
    disp(i);

    co_i = DDR_compute_cost('l','census',prev_dis,L_mat(:,:,i),R_mat(:,:,i),WINDOW_SIZE,D_RANGE,R_RANGE);

    [dis_i, Lr_i]= Lr_total('l',1,THRESHOLD,Lr_9('l',co_i,p1,p2),Lr_3('l',co_i,p1,p2),Lr_0('l',co_i,p1,p2),Lr_6('l',co_i,p1,p2),Lr_t('l',0,co_i,Lr_prev,p1_t,p2_t),L_mat(:,:,i),R_mat(:,:,i),WINDOW_SIZE);
    
    DDR_Dis_Map(:,:,i) = dis_i;
    
    
    prev_dis = dis_i;
    Lr_prev = Lr_i;
    
end

toc



size(DDR_Dis_Map)


% 
% dis = prev_dis(:,D_RANGE+1:end)/4;
% dis=(dis-min(dis(:)))/(max(dis(:))-min(dis(:)));
% dis=uint8(dis*255);
% imshow(dis)


for w = FIRST_FRAME:LAST_FRAME
    
    dis = DDR_Dis_Map(:,D_RANGE+1:end,w)/4;
    dis=(dis-min(dis(:)))/(max(dis(:))-min(dis(:)));
    dis=uint8(dis*255);
    
    idx=num2str(w);
    filename_i = ['TESTS/DDR9/f',idx,'.jpg'];
    imwrite(dis,filename_i)
end


% dis = DDR_Dis_Map(:,D_RANGE+1:end,w)/4;
% dis=(dis-min(dis(:)))/(max(dis(:))-min(dis(:)));
% dis=uint8(dis*255);
    
disp('TEST COMPLETE, SIR')



