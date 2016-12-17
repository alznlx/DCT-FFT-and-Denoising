% 原图像
originImage = im2double(rgb2gray(imread('lena.jpg')));
% 带椒盐噪声的图像
imageWithNoise = im2double(imread('lena_noise.jpg'));
% 带高斯噪声的图像
% imageWithNoise = im2double(imread('lena_gaussian_noise.jpg'));
[rows, cols] = size(originImage);
figure(1), imshow(originImage), title('原图像');
figure(2), imshow(imageWithNoise), title('带噪图像');
y = imageWithNoise;

% 二维统计滤波实现
% 指定模板尺寸与k值
boxSize = 3;k = 5;
template = zeros(boxSize);
for i = 1:rows-boxSize+1
    for j = 1:cols-boxSize+1
        % 取模板内元素
        template = imageWithNoise(i:i+(boxSize-1),j:j+(boxSize-1));
        % 用排序后第k个值替换模板中心点像素值
        v = sort(template(:));
        y(i+(boxSize-1)/2,j+(boxSize-1)/2) = v(k);
    end
end

figure(3), imshow(y), title('滤波后图');

% 计算滤波后MSE
se2 = (y - originImage).^2;
MSE2 = sum(se2(:)) / (rows * cols);
fprintf('滤波后MSE=%f\n', MSE2);