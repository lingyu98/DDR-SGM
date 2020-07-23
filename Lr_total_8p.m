function [Final_dis_map, Lr_tot] = Lr_total_8p(base,DDR_MODE,TH,lr1,lr4,lr7,lr10,lr9,lr3,lr0,lr6,lrt,left_img,right_img,win_size)



[r,c,DRANGE] = size(lr9);

Final_dis_map = (DRANGE+1)*ones(r,c);

Lr_tot = lr1+lr4+lr7+lr10+lr9+lr3+lr0+lr6+lrt;

if DDR_MODE
    if strcmp(base,'l')==1
        for i = 1:r
            for j = 1+DRANGE:c

                Lr_ij_min = min(Lr_tot(i,j,:));

                if Lr_ij_min > TH

                    
                    %替换
                    Lrl = lr9(i,max(j-1,1+DRANGE),:);%LEFT NEIGHBOR
                    Lrr = lr3(i,min(j+1,c),:);
                    Lra = lr0(max(1,i-1),j,:);
                    Lrb = lr6(min(i+1,r),j,:);
                    Lr_tot(i,j,:) =full_range_search_Lr_tot(i,j,Lrl,Lrr,Lra,Lrb,left_img,right_img,win_size);%回到costmap，在ij点fullrange计算Lr_tot向量
                    Lr_ij_min = min(Lr_tot(i,j,:));
                else
                end

                d_candidateds = find(Lr_tot(i,j,:) == Lr_ij_min);%出现多个最小值
                Final_dis_map(i,j) = DRANGE-d_candidateds(end);
            end
        end
    end
    
else
    if strcmp(base,'l')==1
        for i = 1:r
            for j = 1+DRANGE:c
                Lr_ij_min = min(Lr_tot(i,j,:));
                d_candidateds =find(Lr_tot(i,j,:) == Lr_ij_min);%出现多个最小值
                Final_dis_map(i,j) = DRANGE-d_candidateds(end);
            end
        end
    end
    
end

end
