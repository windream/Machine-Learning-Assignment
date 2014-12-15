function [] = CSCI567_hw2()

%Iono
%[IonoTrainData, IonoTrainLabel] = getIonosphereData('hw2_data\ionosphere\ionosphere_train.dat',269,35);
%[IonoTestData, IonoTestLabel] = getIonosphereData('hw2_data\ionosphere\ionosphere_test.dat',82,35);

[IonoTrainData, IonoTrainLabel] = getIonosphereData('hw2_data/ionosphere/ionosphere_train.dat',269,35);
[IonoTestData, IonoTestLabel] = getIonosphereData('hw2_data/ionosphere/ionosphere_test.dat',82,35);

%1
disp('1');
%[EmailTrainData, EmailTrainLabel] = genFeature('hw2_data\spam\train','hw2_data\spam\vocab.dat','train');
%[EmailTestData, EmailTestLabel] = genFeature('hw2_data\spam\test','hw2_data\spam\vocab.dat','test');

[EmailTrainData, EmailTrainLabel] = genFeature('hw2_data/spam/train','hw2_data/spam/vocab.dat');
[EmailTestData, EmailTestLabel] = genFeature('hw2_data/spam/test','hw2_data/spam/vocab.dat');
% disp(bg_feature);

%3.a
figure(1);
% disp(IonoTrainData)
% disp(IonoTrainLabel)
plot3a(IonoTrainData,IonoTrainLabel,0);
figure(2);
plot3a(EmailTrainData, EmailTrainLabel,0);

%3.b
disp('3b');
report3b(IonoTrainData,IonoTrainLabel,0,0);
report3b(EmailTrainData,EmailTrainLabel,0,0);

%4.a
figure(3);
plot3a(IonoTrainData,IonoTrainLabel,0.1);
figure(4);
plot3a(EmailTrainData, EmailTrainLabel,0.1);

%4.b
disp('4b')
for lam = 0:0.05:0.5
    report3b(IonoTrainData,IonoTrainLabel,0.01,lam);
    report3b(EmailTrainData,EmailTrainLabel,0.01,lam);
end

%4.c
plot4c(IonoTrainData,IonoTrainLabel,IonoTestData, IonoTestLabel,5);
plot4c(EmailTrainData,EmailTrainLabel,EmailTestData, EmailTestLabel,10);

%6.a
figure(15);
plot6a(IonoTrainData,IonoTrainLabel,0);
figure(16);
plot6a(EmailTrainData,EmailTrainLabel,0);

%6.b
disp('6b')
report6b(IonoTrainData,IonoTrainLabel,0);
report6b(EmailTrainData,EmailTrainLabel,0);

%6.c
disp('6c')
report6c(IonoTrainData,IonoTrainLabel,IonoTestData,IonoTestLabel,0);
report6c(EmailTrainData,EmailTrainLabel,EmailTestData,EmailTestLabel,0);

%7.a
figure(17);
plotCE = zeros(50,1);
for lam = 0.05:0.05:0.5
    ce = plot7a(IonoTrainData,IonoTrainLabel,lam);
    plotCE = [plotCE,ce];
end
x = 1:1:50;
plot(x,plotCE(:,1)',x,plotCE(:,2)',x,plotCE(:,3)',x,plotCE(:,4)',x,plotCE(:,5)',x,plotCE(:,6)',x,plotCE(:,7)',x,plotCE(:,8)',x,plotCE(:,9)',x,plotCE(:,10)');
legend('lambda=0.05','lambda=0.1','lambda=0.15','lambda=0.2','lambda=0.25','lambda=0.3','lambda=0.35','lambda=0.4','lambda=0.45','lambda=0.5',-1);
xlabel('iteration');
ylabel('cross-entropy function value');
title('cross-entropy function value with regularized case');

figure(18);
disp(18)
plotCE = zeros(50,1);
for lam = 0.05:0.05:0.5
    ce = plot7a(EmailTrainData,EmailTrainLabel,lam);
    plotCE = [plotCE,ce];
end
x = 1:1:50;
plot(x,plotCE(:,1)',x,plotCE(:,2)',x,plotCE(:,3)',x,plotCE(:,4)',x,plotCE(:,5)',x,plotCE(:,6)',x,plotCE(:,7)',x,plotCE(:,8)',x,plotCE(:,9)',x,plotCE(:,10)');
legend('lambda=0.05','lambda=0.1','lambda=0.15','lambda=0.2','lambda=0.25','lambda=0.3','lambda=0.35','lambda=0.4','lambda=0.45','lambda=0.5',-1);
xlabel('iteration');
ylabel('cross-entropy function value');
title('cross-entropy function value with regularized case');

%7.b
disp('7b')
for lam = 0.05:0.05:0.5
    report6b(IonoTrainData,IonoTrainLabel,lam);
    report6b(EmailTrainData,EmailTrainLabel,lam);
end

%7.c
disp('7c')
for lam = 0.05:0.05:0.5
    report6c(IonoTrainData,IonoTrainLabel,IonoTestData,IonoTestLabel,lam);
    report6c(EmailTrainData,EmailTrainLabel,EmailTestData,EmailTestLabel,lam);
end


end