function [] = CSCI567_hw4()

row = 500;
[GaussianClass, GaussianData] = load2DGaussianData('2DGaussian.csv', row);

%2.a
k = [2,3,5];
for i = 1:3
    kmeans(k(i), GaussianData, row, i);
end

%2.b
kmeans4(GaussianData, row);

%3.d
k = [3,8,15];
image = imread('hw4.jpg');
[length, width, rbg] = size(image);
im = reshape(image,length*width,rbg);
% figure(5)
% imshow(image);
for i = 1:3
    kmeansImage(k(i), im, length, width, i+4);
end




end
