function [s] = sigmod(a)

s = 1.0 / (1+exp(-a));
% disp(s)
if s<1e-16
    s = 1e-16;
elseif s>1-1e-16
    s = 1-1e-16;
end

end