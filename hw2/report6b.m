function [] = report6b(X, Y, lambda)

[N,D] = size(X);

w = zeros(D,1);
b = 0.1;

for i = 1:5
    sumW = zeros(1,D);
    sumB = 0;
    for n = 1:N
        sumW = sumW + (sigmod(b + X(n,:)* w) - Y(n,1)) * X(n,:);
        sumB = sumB + (sigmod(b + X(n,:)* w) - Y(n,1));
    end
    w = w - 0.01 * (sumW + 2 * lambda * w')';
%         disp(w);
    b = b - 0.01 * (sumB + 2 * lambda * b);
end

for i = 1:50
    sumWe = zeros(1,D);
    sumBe = 0;
    for n = 1:N
        sumWe = sumWe + (sigmod(b + X(n,:)* w) - Y(n,1)) * X(n,:);
        sumBe = sumBe + (sigmod(b + X(n,:)* w) - Y(n,1));
    end
    
    sumWh = zeros(D,D);
    sumBh = 0;
    for n = 1:N
        sig = sigmod(b + X(n,:)* w);
        sumWh = sumWh + sig * (1 - sig) * X(n,:)' * X(n,:);
        sumBh = sumBh + sig * (1 - sig);
    end
        
    w = w -  pinv(sumWh +  eye(D) .* (2 * lambda)) * (sumWe + 2 * lambda * w')';
%         disp(w);
    b = b - 1.0 / (sumBh + 2 * lambda) * (sumBe + 2 * lambda * b);
    
    
end

disp(squ(w));

end