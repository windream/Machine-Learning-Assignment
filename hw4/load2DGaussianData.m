function [class, data] = load2DGaussianData(file, row)

fid = fopen(file,'r');
class = zeros(row,1);
data = zeros(row,2);

fgetl(fid);
for r = 1:row
    line = fgetl(fid);
    list = strsplit(line,',');
    
    class(r,1) = str2double(list(1));
    data(r,1) = str2double(list(2));
    data(r,2) = str2double(list(3));
end

fclose(fid);

end
