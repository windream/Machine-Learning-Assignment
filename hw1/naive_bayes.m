function [new_accu, train_accu] = naive_bayes(train_data, train_label, new_data, new_label)
% naive bayes classifier
% Input:
%  train_data: N*D matrix, each row as a sample and each column as a
%  feature
%  train_label: N*1 vector, each row as a label
%  new_data: M*D matrix, each row as a sample and each column as a
%  feature
%  new_label: M*1 vector, each row as a label
%
% Output:
%  new_accu: accuracy of classifying new_data
%  train_accu: accuracy of classifying train_data 
%
% CSCI 576 2014 Fall, Homework 1
[N,D]=size(train_data);
[M,~]=size(new_data);

[accu]=compute(train_data,train_label,new_data,new_label);
new_accu=accu/M;

train_accu=0;
for i=1:N
    train_data1=train_data;
    new_data1=train_data1(i,:);
    train_data1(i,:)=[];
    train_label1=train_label;
    new_label1=train_label1(i,:);
    train_label1(i,:)=[];
    
    [accu]=compute(train_data1,train_label1,new_data1,new_label1);
    train_accu=train_accu+accu;
end

train_accu=train_accu/N;

end

function [accu]=compute(train_data,train_label,new_data,new_label)
    [N,D]=size(train_data);
    [M,~]=size(new_data);
    [C,~]=size(unique(train_label));
    accu=0;
    
    Pinum=zeros(C,1);
    for i=1:N
        Pinum(train_label(i))=Pinum(train_label(i))+1;
    end
    Pi=Pinum/N;

    X = 0;
    for i=1:D
        [u,~]=size(unique(train_data(:,i)));
        if(u>X)
            X=u;
        end
    end
    
    Pnum=zeros(D,X,C);
    P=zeros(D,X,C);
    for i=1:N
        c=train_label(i);
        for d=1:D
            x=train_data(i,d);
            Pnum(d,x,c)=Pnum(d,x,c)+1;
        end
    end
    for c=1:C
        P(:,:,c)=Pnum(:,:,c)/Pinum(c);
    end

    for i=1:M
        max=0;
        id=0;
        for c=1:C
            Pro=Pi(c);
            for d=1:D
                Pro=Pro*P(d,new_data(i,d),c);    
            end
            if (Pro>max) 
                max=Pro;
                id=c;
            end
        end
        if (id==new_label(i))
            accu=accu+1;
        end
    end
end