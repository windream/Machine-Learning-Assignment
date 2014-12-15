function [objdata] = preprocess(traindata, objdata)

me = mean(traindata);
staDev = std(traindata);

% disp(me)
% disp(staDev)

[r,c] = size(objdata);
for i = 1:r
    objdata(i,:) = (objdata(i,:) - me) ./ staDev;
end

end