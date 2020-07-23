function Census_Map = generate_census_map(input_image,win_size)

[r,c] = size(input_image);
Census_Map = zeros(r,c,win_size*win_size);

radius = (win_size-1)/2;


for i = 1+radius:r-radius
    for j = 1+radius:c-radius
        %bit_string_ij = false(1,win_size*win_size);
        neighbor_ij = input_image(i-radius:i+radius,j-radius:j+radius);
        center = neighbor_ij(1+radius,1+radius);
        win_template = neighbor_ij > center;
        bit_string_ij = win_template(:);
        Census_Map(i,j,:) = bit_string_ij;
    end
end 


end

