function [] = kmeans4(data, n)

k = 4;

objValue = zeros(5,50);


for cnt = 1:5
    u = zeros(k,2);
    r = zeros(n,k);
    class = zeros(n);
    randomK = randperm(n,k);
    for i = 1:k
        u(i,:) = data(randomK(i),:);
    end
    
    for iteration = 1:50
        for i = 1:n
            minDis = 10.0;
            mink = 0;

            for j = 1:k
                dis = (data(i,1) - u(j,1))^2 + (data(i,2) - u(j,2))^2;
                if dis < minDis
                    minDis = dis;
                    mink = j;
                end
            end
            
            r(i,:) = zeros(1,k);
            r(i,mink) = 1;
            class(i) = mink;
        end

        for i = 1:k
            s = zeros(1,2);
            for j = 1:n
                s = s + data(j,:) * r(j,i);
            end
            u(i,:) = s / sum(r(:,i));

        end
        
        obj = 0;
        for i = 1:n
            for j = 1:k
                obj = obj + r(i,j) * (norm(data(i,:)-u(j,:))^2);
            end
        end
        objValue(cnt,iteration) = obj;
    end

    disp(cnt)
    
end  

figure(4);
clf;
hold on;
xx = 1:1:50;
plot(xx,objValue(1,:),xx,objValue(2,:),xx,objValue(3,:),xx,objValue(4,:),xx,objValue(5,:));
legend('1','2','3','4','5',-1);

      


end
