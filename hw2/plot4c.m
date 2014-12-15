function [] = plot4c(xTrain, yTrain, xTest, yTest, num)

[N,D] = size(xTrain);
[NT,DT] = size(xTest);

w = zeros(D,1);
b = 0.1;
step = [0.001,0.01,0.05,0.1,0.5];


for s = 1:5
    plotCE = zeros(11,2);
    for i = 1:11
        lambda = 0.05 * (i - 1);
        for j = 1:50
            sumW = zeros(1,D);
            sumB = 0;
            for n = 1:N
                sumW = sumW + (sigmod(b + xTrain(n,:)* w) - yTrain(n,1)) * xTrain(n,:);
                sumB = sumB + (sigmod(b + xTrain(n,:)* w) - yTrain(n,1));
            end
            w = w - step(s) * (sumW + 2 * lambda * w')';
    %         disp(w);
            b = b - step(s) * (sumB + 2 * lambda * b); 
        end
    
        sumCE = 0;
        for n = 1:N
            [sig] = sigmod(b + xTrain(n,:) * w);
    %             disp(sig);
            sumCE =  sumCE - yTrain(n,1) * log(sig) - (1 - yTrain(n,1)) * log(1 - sig);
        end
        plotCE(i,1) = sumCE + lambda * squ(w) * squ(w);
        
        sumCE = 0;
        for n = 1:NT
            [sig] = sigmod(b + xTest(n,:) * w);
    %             disp(sig);
            sumCE =  sumCE - yTest(n,1) * log(sig) - (1 - yTest(n,1)) * log(1 - sig);
        end
        plotCE(i,2) = sumCE + lambda * squ(w) * squ(w);

    end


    % disp(plotCE);
    figure(num);
    num = num + 1;
    x = 0:0.05:0.5;
    plot(x,plotCE(:,1)',x,plotCE(:,2)');
    legend('train','test',-1);
    xlabel('regularization coefficient');
    ylabel('cross-entropy function value after 50 iteration');
    title('cross-entropy function value with train and test data');



end