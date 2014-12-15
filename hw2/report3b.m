function [] = report3b(X, Y, yita, lambda)

[N,D] = size(X);

w = zeros(D,1);
b = 0.1;
if yita == 0
    step = [0.001,0.01,0.05,0.1,0.5];
else
    step = zeros(1,1);
    step(1) = yita;
end

for s = 1:length(step)
    for i = 1:50
        sumW = zeros(1,D);
        sumB = 0;
        for n = 1:N
            sumW = sumW + (sigmod(b + X(n,:)* w) - Y(n,1)) * X(n,:);
            sumB = sumB + (sigmod(b + X(n,:)* w) - Y(n,1));
        end
        w = w - step(s) * (sumW + 2 * lambda * w')';
%         disp(w);
        b = b - step(s) * (sumB + 2 * lambda * b);
    end
%     disp(step(s));
    disp(squ(w));
end

end
