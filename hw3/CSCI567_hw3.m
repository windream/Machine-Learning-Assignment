function [] = CSCI567_hw3()

load 'splice_train.mat';
train_data = data;
train_label = label;
load 'splice_test.mat';
test_data = data;
test_label = label;

traindata = preprocess(train_data,train_data);
testdata = preprocess(train_data,test_data);
%1


%2


%3.a
[accuracy,time,maxJ] = crossValidation(traindata,train_label);
disp('3.a');
disp(accuracy);
disp(time);

%3.b
disp('3.b');
disp(maxJ);

%3.c
C = 4^maxJ;
[w,b] = trainsvm(traindata,train_label,C);
accu = testsvm(testdata,test_label,w,b);
disp('3.c');
disp(accu);

%4
time = zeros(1,9);
for i = -6:2
    cmd = ['-c ',num2str(4^i),' -v 5 -t 0 -q'];
    
    s = cputime;
    model = svmtrain(train_label,traindata,cmd);
    t = cputime;
    time(i+7) = (t - s) / 5;  
end
disp('4');
disp(time);

%5.a
time = zeros(3,12);
for c = -4:7
    disp(c)
    for d = 1:3
        cmd = ['-c ',num2str(4^c),' -v 5 -t 1 -q -d ',num2str(d)];
        
        s = cputime;
%         disp(c)
%         disp(d)
        model = svmtrain(train_label,traindata,cmd);
        t = cputime;
        time(d,c+5) = (t - s) / 5;  
    end
end
disp('5.a');
disp(time);

%5.b
time = zeros(7,12);
for c = -4:7
    disp(c)
    for g = -7:-1
        cmd = ['-c ',num2str(4^c),' -v 5 -t 2 -q -g ',num2str(4^g)];
        
        s = cputime;
%         disp(c)
%         disp(g)
        model = svmtrain(train_label,traindata,cmd);
        t = cputime;
        time(g+8,c+5) = (t - s) / 5;  
    end
end
disp('5.b');
disp(time);

%5
c = 1;
g = -3;
cmd = [' -c ',num2str(4^c),' -t 2 -q -g ',num2str(4^g)];
model = svmtrain(train_label,traindata,cmd);
[predict_label,accuracy,decision_values] = svmpredict(test_label,testdata,model);
disp('5')
disp(accuracy)







end