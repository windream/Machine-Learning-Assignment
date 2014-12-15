function [] = plot3a(X, Y, lambda)

[N,D] = size(X);

w = zeros(D,1);
b = 0.1;
step = [0.001,0.01,0.05,0.1,0.5];
plotCE = zeros(50,5);

for s = 1:5
    ce = zeros(50,1);
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
        sumCE = 0;
        for n = 1:N
            [sig] = sigmod(b + X(n,:) * w);
%             disp(sig);
            sumCE =  sumCE - Y(n,1) * log(sig) - (1 - Y(n,1)) * log(1 - sig);
        end
        ce(i,1) = sumCE + lambda * squ(w) * squ(w);
%         disp(sumCE);
    end
    plotCE(:,s) = ce(:,1);
end

% disp(plotCE);
x = 1:1:50;
plot(x,plotCE(:,1)',x,plotCE(:,2)',x,plotCE(:,3)',x,plotCE(:,4)',x,plotCE(:,5)');
legend('step=0.001','step=0.01','step=0.05','step=0.1','step=0.5',-1);
xlabel('iteration');
ylabel('cross-entropy function value');
title('cross-entropy function value with different step sizes');
end
