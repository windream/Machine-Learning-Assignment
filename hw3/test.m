function [accu] = test(traindata,trainlabel,testdata,testlabel,C)

traind = preprocess(traindata,traindata);
testd = preprocess(traindata,testdata);

[w,b]=trainsvm(traind,trainlabel,C);
accu = testsvm(testd,testlabel,w,b);



end