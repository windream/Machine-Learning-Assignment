function [ data, label ] = genFeature( directory, dic)
%UNTITLED2 此处显示有关此函数的摘要
%   此处显示详细说明
pathSpam = strcat(directory,'/spam');
pathHam = strcat(directory,'/ham');
fileSpam =  dir(fullfile(pathSpam,'*.txt'));
fileHam =  dir(fullfile(pathHam,'*.txt'));


row = 1014;
dict = getDic(dic,row);
bg_feature = zeros(1,length(dict));
% disp(dict)
dataRow = length(fileSpam) + length(fileHam);


data = zeros(dataRow,length(dict));
label = zeros(dataRow,1);

% disp(pathSpam);
% disp(fileSpam)


for f = 1:length(fileSpam)
    disp(strcat(pathSpam,':',int2str(f)))
    path = strcat(pathSpam,'/',fileSpam(f).name);
%     disp(path)
    fid =  fopen(path,'r');
    text = '';
    while(~feof(fid))
        line = fgetl(fid);
        text = strcat(text,',',line);
    end
%     disp(text)
    data = getBgFeature(text,dict,data,f);
    label(f,1) = 0;
    fclose(fid);
end

for f = 1:length(fileHam)
    disp(strcat(pathHam,':',int2str(f)))
    path = strcat(pathHam,'/',fileHam(f).name);
    fid =  fopen(path,'r');
    text = '';
    while(~feof(fid))
        line = fgetl(fid);
        text = strcat(text,',',line);
    end
    data= getBgFeature(text,dict,data,f+123);
    label(f+length(fileSpam),1) = 1;
    fclose(fid);
end

for i = 1:dataRow
    bg_feature = bg_feature + data(i,:);
end

big3Index = Big3(bg_feature);
for i = 1:3
    word = strcat(dict(big3Index(i)),': ',int2str(bg_feature(big3Index(i))));
    disp(word);
end


end

function [ dict ] = getDic(dic, row)
dict = cell(row,1);

fid = fopen(dic,'r');
for r = 1:row
%     disp(r);
    line = fgetl(fid);
%     disp(line);
    dict{r} = line;
end

fclose(fid);

end

function [ data ] = getBgFeature(text,dic,data,index)
% res = bg_feature;
token = strsplit(text,{' ', '.', ',', '?'});
[dic_size,~] = size(dic); 
% disp(dic_size)

for i = 1:length(token)
    for j = 1:dic_size
%         disp(dic(j));
%         disp(token(i));
        if strcmp(dic(j),token(i))==1
            data(index,j) = data(index,j) + 1;
        end
    end
end

end

function [res] = Big3(array)

res = zeros(1,3);
if array(1) >= array(2)
    if array(1) >= array(3)
        res(1) = 1;
        if array(2) >= array(3)
            res(2) = 2;
            res(3) = 3;
        else
            res(2) = 3;
            res(3) = 2;
        end
    else
        res(1) = 3;
        res(2) = 1;
        res(3) = 2;
    end
else
    if array(2) >= array(3)
        res(1) = 2;
        if array(1) >= array(3)
            res(2) = 1;
            res(3) = 3;
        else
            res(2) = 3;
            res(2) = 1;
        end
    else
        res(1) = 3;
        res(2) = 2;
        res(3) = 1;
    end
end

for i = 4:length(array)
    if array(i) >= array(res(1))
        res(3) = res(2);
        res(2) = res(1);
        res(1) = i;
    elseif array(i) >= array(res(2))
        res(3) = res(2);
        res(2) = i;
    elseif array(i) >= array(res(3))
        res(3) = i;
    end
end

end
