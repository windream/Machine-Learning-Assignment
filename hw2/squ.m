function [res] = squ(w)
n = length(w);
res = 0;
for i = 1:n
    res = res + w(i,1) * w(i,1);
end
res = sqrt(res);
end