function [] = kmeansImage(k, data, length, width, fig)
disp(fig)
[n,m] = size(data);
u = zeros(k,m);
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
        minDis = realmax;
        mink = 0;
        
        for j = 1:k
            dis = norm(double(data(i,:)) - u(j,:))^2;
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
        s = zeros(1,m);
        for j = 1:n
            s = s + double(data(j,:)) * r(j,i);
        end
        u(i,:) = s / sum(r(:,i));
        
    end
    
    if norm(pre_u-u) < 1
        break;
    end
end  

figure(fig);
clf;
hold on;

for i = 1:n
    data(i,:) = u(class(i),:);
end

image = reshape(data,length,width,3);
imshow(image);

      


end
