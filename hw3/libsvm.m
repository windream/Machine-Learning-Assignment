function [accuracy] = libsvm(traindata,trainlabel,testdata,testlabel)

traind=preprocess(traindata,traindata);
testd=preprocess(traindata,testdata);

cmd = ['-c ',num2str(4),' -v 5'];
model = svmtrain(trainlabel,traind,'-c 4 -v 5 -t 0');
[predict_label,accuracy,decision_values] = svmpredict(testlabel,testd,model);


end