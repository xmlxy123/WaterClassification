%
%  do the gabor convolution on Imaga
%
function [gabordata]=Gabor_Texture3(img,GaborReal,GaborImg)

img = im2double(img);
s = [1 2 3 4];%�߶�ȡֵ
temp = zeros(264,264);%��ͼ��ȱ�ٵĲ��ֲ�0
temp(5:260,5:260) = img;
img = temp;

%%
%ͼ��ֿ���Gabor�������ͣ��õ�24*24����ͼ
GaborFeature = zeros(576,8,4);%�洢Gabor����,ͼ��ֿ飬ÿ�����Ӧ��ͬ�Ƕȣ���ͬscale��Ϊ������ά��
GaborFeatureE = zeros(576,8,4);%�洢Gabor Real����,ͼ��ֿ飬ÿ�����Ӧ��ͬ�Ƕȣ���ͬscale��Ϊ������ά��
GaborFeatureO = zeros(576,8,4);%�洢Gabor Imaginary����,ͼ��ֿ飬ÿ�����Ӧ��ͬ�Ƕȣ���ͬscale��Ϊ������ά��
for scale = 1:4
    for direction = 1:8
        even = GaborReal(:,:,(scale-1)*8+direction);%ʵ��
        odd = GaborImg(:,:,(scale-1)*8+direction);%�鲿
        for i = 1:24
            for j = 1:24
                tempReal = imfilter(img((j-1)*11+1:j*11,(i-1)*11+1:i*11),even);
                tempImg = imfilter(img((j-1)*11+1:j*11,(i-1)*11+1:i*11),odd);
                tempSum = [sum(tempReal(:)) sum(tempImg(:))];
                r1 = norm(tempSum,2);
                GaborFeature((i-1)*24+j,direction,scale) = r1;
                GaborFeatureE((i-1)*24+j,direction,scale) = sum(tempReal(:));
                GaborFeatureO((i-1)*24+j,direction,scale) = sum(tempImg(:));
            end
        end
    end
end

%%
%��һ�ֶ�ֵ����
a = zeros(4,576);%ÿ���߶�Ϊһ�У�����ͼƬ�и�����Ķ�ֵ����
ari = zeros(4,576);%ÿ���߶�Ϊһ�У�����ͼƬ�и�����Ķ�ֵ���룬������ת������
%�ڶ��ֶ�ֵ����
b = zeros(4,576);%ÿ���߶�Ϊһ�У�����ͼƬ�и�����Ķ�ֵ����
bri = zeros(4,576);%ÿ���߶�Ϊһ�У�����ͼƬ�и�����Ķ�ֵ���룬������ת������
%�����ֶ�ֵ����
c = zeros(4,576);%ÿ���߶�Ϊһ�У�����ͼƬ�и�����Ķ�ֵ����
cri = zeros(4,576);%ÿ���߶�Ϊһ�У�����ͼƬ�и�����Ķ�ֵ���룬������ת������

for scale = 1:4
    %type1
    tempR = GaborFeature(:,:,scale);
    avgR = mean(tempR);
    %type2
    tempD = tempR-repmat(avgR,size(tempR,1),1);
    avgD = mean(tempD);
    %type3
    tempU = abs(GaborFeatureE(:,:,scale))-abs(GaborFeatureO(:,:,scale));
    avgU = mean(tempU);
    
    for j = 1:576
        tempA = [];
        tempB = [];
        tempC = [];
        for direction = 1:8%binaryzation
            if (tempR(j,direction) - avgR(direction)) >= 0
                tempA(direction) = 2.^(direction-1);
            else
                tempA(direction) = 0;
            end
            if (tempD(j,direction) - avgD(direction)) >= 0
                tempB(direction) = 2.^(direction-1);
            else
                tempB(direction) = 0;
            end
            if (tempU(j,direction) - avgU(direction)) >= 0
                tempC(direction) = 2.^(direction-1);
            else
                tempC(direction) = 0;
            end
        end
        
        a(scale,j) = sum(tempA);
        b(scale,j) = sum(tempB);
        c(scale,j) = sum(tempC);
        % ROR
        if a(scale,j) == 255 || a(scale,j) == 0
            ari(scale,j) = a(scale,j);
        else
            tempRotation = [];
            temp = sum(tempA);
            for n = 1:8
                deciTemp = dec2bin(temp,8);
                deciTemp = circshift(deciTemp',1)';
                temp = bin2dec(deciTemp);
                tempRotation(n) = temp;
            end
            ari(scale,j) = max(tempRotation);
        end
        
        if b(scale,j) == 255 || b(scale,j) == 0
            bri(scale,j) = b(scale,j);
        else
            tempRotation = [];
            temp = sum(tempB);
            for n = 1:8
                deciTemp = dec2bin(temp,8);
                deciTemp = circshift(deciTemp',1)';
                temp = bin2dec(deciTemp);
                tempRotation(n) = temp;
            end
            bri(scale,j) = max(tempRotation);
        end
            
        if c(scale,j) == 255 || c(scale,j) == 0
            cri(scale,j) = c(scale,j);
        else
            tempRotation = [];
            temp = sum(tempC);
            for n = 1:8
                deciTemp = dec2bin(temp,8);
                deciTemp = circshift(deciTemp',1)';
                temp = bin2dec(deciTemp);
                tempRotation(n) = temp;
            end
            cri(scale,j) = max(tempRotation);
        end
       
    end
end

%%
%����ֱ��ͼͳ��������0-255��������ͳ�Ƹ���
histogram = zeros(12,8);
for i = 1:8
    histogram(1,i) = length(find(ari(1,:)>=((i-1)*32)&ari(1,:)<=(i*32-1)));
    histogram(2,i) = length(find(ari(2,:)>=((i-1)*32)&ari(2,:)<=(i*32-1)));
    histogram(3,i) = length(find(ari(3,:)>=((i-1)*32)&ari(3,:)<=(i*32-1)));
    histogram(4,i) = length(find(ari(4,:)>=((i-1)*32)&ari(4,:)<=(i*32-1)));
    histogram(5,i) = length(find(bri(1,:)>=((i-1)*32)&bri(1,:)<=(i*32-1)));
    histogram(6,i) = length(find(bri(2,:)>=((i-1)*32)&bri(2,:)<=(i*32-1)));
    histogram(7,i) = length(find(bri(3,:)>=((i-1)*32)&bri(3,:)<=(i*32-1)));
    histogram(8,i) = length(find(bri(4,:)>=((i-1)*32)&bri(4,:)<=(i*32-1)));
    histogram(9,i) = length(find(cri(1,:)>=((i-1)*32)&cri(1,:)<=(i*32-1)));
    histogram(10,i) = length(find(cri(2,:)>=((i-1)*32)&cri(2,:)<=(i*32-1)));
    histogram(11,i) = length(find(cri(3,:)>=((i-1)*32)&cri(3,:)<=(i*32-1)));
    histogram(12,i) = length(find(cri(4,:)>=((i-1)*32)&cri(4,:)<=(i*32-1)));
end

% res=zeros(12,576);
% res=[ari;bri;cri];
gabordata = reshape(histogram,1,96);
% gabordata=res;

end
