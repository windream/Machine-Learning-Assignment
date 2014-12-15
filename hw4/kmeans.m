function [] = kmeans(k, data, n, fig)
disp(fig)

u = zeros(k,2);
r = zeros(n,k);
class = zeros(n);
randomK = randperm(n,k);

for i = 1:k
    u(i,:) = data(randomK(i),:);
end

cnt = 0;
while(1)
    cnt = cnt + 1;
%     disp(k)
    disp(cnt)
    pre_u = u;
    
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
    
    if norm(pre_u-u) < 0.01
        break;
    end
end  

figure(fig);
clf;
hold on;

for i = 1:k
    plot(u(i,1),u(i,2),'k+','MarkerSize',10,'LineWidth',3)
end

for i = 1:n
%     disp(i)
    if class(i) == 1
        plot(data(i,1),data(i,2),'r.');
    elseif class(i) == 2
        plot(data(i,1),data(i,2),'b.');
    elseif class(i) == 3
        plot(data(i,1),data(i,2),'g.');
    elseif class(i) == 4
        plot(data(i,1),data(i,2),'y.');
    else
        plot(data(i,1),data(i,2),'m.');
    end
end
      


end
