function [accuracy,time,maxJ] = crossValidation(train_data,train_label)

%traindata = preprocess(train_data,train_data);

% rtraindata = train_data;
% rtrainlabel = train_label;

r = randperm(size(train_data,1));
rtraindata = train_data(r,:);
rtrainlabel = train_label(r,:);

[N,D] = size(rtraindata);

dataVal = zeros(N/5,D);
labelVal = zeros(N/5,1);
dataTrain = zeros(4*N/5,D);
labelTrain = zeros(4*N/5,1);

accuracy = zeros(1,9);
time = zeros(1,9);

maxAccu = 0;
maxAccuTime = 0;
maxJ = -6;

for j = -6:2
    accu = 0;
    trainTime = 0;
    
    for i = 1:5
        dataVal = rtraindata((i-1)*N/5+1 : i*N/5,:);
        labelVal = rtrainlabel((i-1)*N/5+1 : i*N/5,:);
        if i == 1
            dataTrain = rtraindata(N/5+1 : N,:);
            labelTrain = rtrainlabel(N/5+1 : N,:);
        elseif i == 5
            dataTrain = rtraindata(1 : 4*N/5,:);
            labelTrain = rtrainlabel(1 : 4*N/5,:);
        else
            dataTrain(1:(i-1)*N/5,:) = rtraindata(1 : (i-1)*N/5,:);
            dataTrain((i-1)*N/5+1:4*N/5,:) = rtraindata(i*N/5+1:N,:);
            labelTrain(1:(i-1)*N/5,:) = rtrainlabel(1 : (i-1)*N/5,:);
            labelTrain((i-1)*N/5+1:4*N/5,:) = rtrainlabel(i*N/5+1:N,:);
        end
        
        s = cputime;
        [w,b] = trainsvm(dataTrain,labelTrain,4^j);
        t = cputime;
        trainTime = trainTime + t - s;
        
        accu = accu + testsvm(dataVal,labelVal,w,b);
    end
    
    trainTime = trainTime / 5;
    accu = accu / 5;
    
    %disp(trainTime)
    %disp(accu)
    
    accuracy(j+7) = accu;
    time(j+7) = trainTime;
    
    if accu > maxAccu
        maxAccu = accu;
        maxJ = j;
    elseif accu == maxAccu
        if trainTime < maxAccuTime
            maxAccu = accu;
        end
    end
end





end