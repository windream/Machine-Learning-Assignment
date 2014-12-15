function [data,label] = getIonosphereData( file, row, column )

fid = fopen(file,'r');
data = zeros(row,column);
label = zeros(row,1);

for r = 1:row
    tline = fgetl(fid);
%     disp(tline);
%     disp(r);
    list = strsplit(tline,',');
    
    for c = 1:column - 1
        data(r,c) = str2double(list(c));
    end
    if strcmp(list(column),'b') == 1
        label(r,1) = 1;
    elseif strcmp(list(column),'g') == 0
        label(r,1) = 0;
    end
end

fclose(fid);

end