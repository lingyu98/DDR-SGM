function H_dis = Hamming_dis(vec1,vec2)
l = length(vec1);

sum = 0;

for i = 1:l
    sum = sum+ (vec1(i) ~= vec2(i));
end


H_dis = sum/(l);


end

