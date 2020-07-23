function [Left_mat, Right_mat] = Load_images(idx_first,idx_last,res)

num_of_frames = idx_last-idx_first+1;

[r, c] = size(imresize(double(rgb2gray(imread('tanks/L0001.png'))) / 255.0,res));


Left_mat = zeros(r,c,num_of_frames);
Right_mat = zeros(r,c,num_of_frames);


for i = idx_first:idx_last
    idx=num2str(i,'%04d');
    
    LEFT_I = imread(['tanks/L',idx,'.png']);
    L_i = imresize(double(rgb2gray(LEFT_I)) / 255.0,res);
    
    RIGHT_I = imread(['tanks/R',idx,'.png']);
    R_i = imresize(double(rgb2gray(RIGHT_I)) / 255.0,res);
    
    Left_mat(:,:,i) = L_i;
    Right_mat(:,:,i) = R_i;
    
end


end

