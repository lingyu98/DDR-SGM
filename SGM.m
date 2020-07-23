% clc
% clear
% 
% RES = 1;
% WINDOW_SIZE = 11;
% THRESHOLD = 100;
% DRANGE = 64;
% p1 = 0.1;
% p2 = 2;
% 
% LEFT = imread('view1.png');
% RIGHT = imread('view5.png');
% 
% Left = imresize(double(rgb2gray(LEFT)) / 255.0, RES);
% Right = imresize(double(rgb2gray(RIGHT)) / 255.0, RES);
% 
% tic

% [co,dis] = compute_cost('l','census',Left,Right,WINDOW_SIZE);%bases,cost,input l,input r,size of window
disp('cmap computation done')
dis1 = Lr_total('l',0,THRESHOLD,Lr_9('l',co,p1,p2),Lr_3('l',co,p1,p2),Lr_0('l',co,p1,p2),Lr_6('l',co,p1,p2),0,Left,Right,WINDOW_SIZE);

toc

%have a look
dis = dis1(:,DRANGE+1:end);
dis=(dis-min(dis(:)))/(max(dis(:))-min(dis(:)));
dis=uint8(dis*255);
imshow(dis)



    
    
%------------------------------- trash -----------------------------
%test BT_cost
% Left = [1 2 3; 4 13 6; 7 8 9]
% Right = [3 4 5; 6 7 8; 9 10 11]
% 
% P = [2,2];
% Q = [2,2];
% 
% C = BT_cost(Left,Right,P,Q,3)



%test census_cost
% 

% 
% Left = [35 31 22 20 19; 40 17 25 30 18; 35 25 20 23 26; 25 35 24 24 27; 30 42 40 17 19]
% Right = [70 65 45 40 40; 82 35 51 60 45; 63 52 40 53 53; 50 72 50 51 55; 60 80 80 35 42]
% 
% 
% P = [3,3];
% Q = [3,3];
% 
% tic
% C = census_cost(Left,Right,P,Q,5)
% 
% toc

%test compute_cost
% Left = [35 31 22 20 19; 40 17 25 30 18; 35 25 20 23 26; 25 35 24 24 27; 30 42 40 17 19];
% Right = [70 65 45 40 40; 82 35 51 60 45; 63 52 40 53 53; 50 72 50 51 55; 60 80 80 35 42];
% 
%------------------------------- trash -----------------------------