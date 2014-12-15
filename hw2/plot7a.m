function [ plotCE ] = plot7a(xTrain, yTrain, lambda)

[N,D] = size(xTrain);

w = zeros(D,1);
b = 0.1;
plotCE = zeros(50,1);

for i = 1:5
    sumW = zeros(1,D);
    sumB = 0;
    for n = 1:N
        sumW = sumW + (sigmod(b + xTrain(n,:)* w) - yTrain(n,1)) * xTrain(n,:);
        sumB = sumB + (sigmod(b + xTrain(n,:)* w) - yTrain(n,1));
    end
    w = w - 0.01 * (sumW + 2 * lambda * w')';
%         disp(w);
    b = b - 0.01 * (sumB + 2 * lambda * b);
end

for i = 1:50
    disp(i)
    sumWe = zeros(1,D);
    sumBe = 0;
    for n = 1:N
        sumWe = sumWe + (sigmod(b + xTrain(n,:)* w) - yTrain(n,1)) * xTrain(n,:);
        sumBe = sumBe + (sigmod(b + xTrain(n,:)* w) - yTrain(n,1));
    end
    
    sumWh = zeros(D,D);
    sumBh = 0;
    for n = 1:N
        sig = sigmod(b + xTrain(n,:)* w);
        sumWh = sumWh + sig * (1 - sig) * xTrain(n,:)' * xTrain(n,:);
        sumBh = sumBh + sig * (1 - sig);
    end
        
    w = w - pinv(sumWh +  eye(D) .* (2 * lambda)) * (sumWe + 2 * lambda * w')';
%         disp(w);
    b = b - 1.0 / (sumBh + 2 * lambda) * (sumBe + 2 * lambda * b);
    
    sumCE = 0;
    for n = 1:N
        sig = sigmod(b + xTrain(n,:) * w);
%             disp(sig);
        sumCE =  sumCE - yTrain(n,1) * log(sig) - (1 - yTrain(n,1)) * log(1 - sig);
    end
    plotCE(i,1) = sumCE + lambda * squ(w) * squ(w);
%         disp(sumCE);

    
end

end