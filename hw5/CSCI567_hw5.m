function [] = CSCI567_hw5()

load('face_data.mat');
% 
%4.c
N = 640;
X = zeros(N,2500);
for i = 1:N
    xx = image{i};
    start_pos = 1;
    for j = 1:50
        X(i,start_pos:start_pos+49) = xx(j,:);
        start_pos = start_pos + 50;
    end
end

mu = mean(X);
normX = bsxfun(@minus, X, mu);
eigenvectors = pca_fun(normX,5);

for i = 1:5
    img = eigenvectors(:,i)';
    figure(i);
    imshow(reshape(img,50,50),[]);
end


%4.d
d = [20,50,100,200];

optRBFc = zeros(1,4);
optlc = zeros(1,4);
optg = zeros(1,4);
LinearAccu = zeros(1,4);
RBFAccu = zeros(1,4);
for i = 1:4
    eigenvecs = pca_fun(normX,d(i));
    Zp = normX * eigenvecs;
    disp(size(Zp))
    
    XX = {zeros(0,d(i)),zeros(0,d(i)),zeros(0,d(i)),zeros(0,d(i)),zeros(0,d(i))};
    disp(size(XX))
    YY = {zeros(0,1),zeros(0,1),zeros(0,1),zeros(0,1),zeros(0,1)};
    disp(size(YY))
    for k = 1:N
        XX{1,subsetID(1,k)} = [XX{1,subsetID(1,k)};Zp(k,:)];
        YY{1,subsetID(1,k)} = [YY{1,subsetID(1,k)};personID(1,k)];
    end
    
    
    for lc = -10:10
        cmd = ['-c ',num2str(4^lc),' -t 1 -q'];
        LinearaverAccu = 0;
        for j = 1:5
            testX = XX{1,j};
            testY = YY{1,j};
            if j == 1
                trainX = cat(1,XX{1,2},XX{1,3},XX{1,4},XX{1,5});
                trainY = cat(1,YY{1,2},YY{1,3},YY{1,4},YY{1,5});
            elseif j == 2
                trainX = cat(1,XX{1,1},XX{1,3},XX{1,4},XX{1,5});
                trainY = cat(1,YY{1,1},YY{1,3},YY{1,4},YY{1,5});
            elseif j == 3
                trainX = cat(1,XX{1,2},XX{1,1},XX{1,4},XX{1,5});
                trainY = cat(1,YY{1,2},YY{1,1},YY{1,4},YY{1,5});
            elseif j == 4
                trainX = cat(1,XX{1,2},XX{1,3},XX{1,1},XX{1,5});
                trainY = cat(1,YY{1,2},YY{1,3},YY{1,1},YY{1,5});
            else
                trainX = cat(1,XX{1,2},XX{1,3},XX{1,4},XX{1,1});
                trainY = cat(1,YY{1,2},YY{1,3},YY{1,4},YY{1,1});
            end
            
            model = svmtrain(trainY,trainX,cmd);
            [predict_label,accuracy,decision_values] = svmpredict(testY,testX,model);
            LinearaverAccu = LinearaverAccu + accuracy(1);
        end
        LinearaverAccu = LinearaverAccu / 5;
        
        if LinearaverAccu > LinearAccu(1,i)           
            LinearAccu(1,i) = double(LinearaverAccu);
            optlc(1,i) = lc;
        end
        
    end

    for RBFc = -10:10
        for g = -10:10
            cmd = ['-c ',num2str(4^RBFc),' -t 2 -q -g ',num2str(4^g)];
            
            RBFaverAccu = 0;
            for j = 1:5
                testX = XX{1,j};
                testY = YY{1,j};
                if j == 1
                    trainX = cat(1,XX{1,2},XX{1,3},XX{1,4},XX{1,5});
                    trainY = cat(1,YY{1,2},YY{1,3},YY{1,4},YY{1,5});
                elseif j == 2
                    trainX = cat(1,XX{1,1},XX{1,3},XX{1,4},XX{1,5});
                    trainY = cat(1,YY{1,1},YY{1,3},YY{1,4},YY{1,5});
                elseif j == 3
                    trainX = cat(1,XX{1,2},XX{1,1},XX{1,4},XX{1,5});
                    trainY = cat(1,YY{1,2},YY{1,1},YY{1,4},YY{1,5});
                elseif j == 4
                    trainX = cat(1,XX{1,2},XX{1,3},XX{1,1},XX{1,5});
                    trainY = cat(1,YY{1,2},YY{1,3},YY{1,1},YY{1,5});
                else
                    trainX = cat(1,XX{1,2},XX{1,3},XX{1,4},XX{1,1});
                    trainY = cat(1,YY{1,2},YY{1,3},YY{1,4},YY{1,1});
                end

                model = svmtrain(trainY,trainX,cmd);
                [predict_label,accuracy,decision_values] = svmpredict(testY,testX,model);
                RBFaverAccu = RBFaverAccu + accuracy(1);
            end
            RBFaverAccu = RBFaverAccu / 5;
            
            if RBFaverAccu > RBFAccu(1,i)
                RBFAccu(1,i) = RBFaverAccu;
                optRBFc(1,i) = RBFc;
                optg(1,i) = g;
            end
            
        end
    end
end

disp('optRBFc')
disp(optRBFc)
disp('optlc')
disp(optlc)
disp('optg')
disp(optg)
disp('LinearAccu')
disp(LinearAccu)
disp('RBFAccu')
disp(RBFAccu)

%5.c
load('hmm_data.mat');
A = [0.7,0.3;0.3,0.7];
E = [0.25,0.25,0.25,0.25;0.25,0.25,0.25,0.25];
A1 = zeros(2,2);
E1 = zeros(2,4);
A2 = zeros(2,2);
E2 = zeros(2,4);
[A1,E1] = baumwelch(data,A,E,500);
[A2,E2] = hmmtrain(data,A,E);

disp('A_baumwelch')
disp(A1)
disp('A_hmmtrain')
disp(A2)
disp('E_baumwelch')
disp(E1)
disp('E_hmmtrain')
disp(E2)


end