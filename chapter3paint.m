I = imread('E:\water\1\c3\polluted_199_6.jpg');
I=imresize(I,[256 256]);
% figure(1);
% imshow(I);
HSV=rgb2hsv(I);
H = HSV(:, :, 1);
S = HSV(:, :, 2);
V = HSV(:, :, 3);
tic
%%
% 提取傅里叶变换后的纹理特征
hf=fft2(H);%进行傅里叶变换
sf=fft2(S);
vf=fft2(V);
hf=log(abs(fftshift(hf)));%对傅里叶变换后的图像进行象限转换，求复数的模，得到变换后的幅值
sf=log(abs(fftshift(sf)));
vf=log(abs(fftshift(vf)));
%做个normalization
hf=(hf-min(hf(:)))/(max(hf(:))-min(hf(:)));
sf=(sf-min(sf(:)))/(max(sf(:))-min(sf(:)));
vf=(vf-min(vf(:)))/(max(vf(:))-min(vf(:)));

% figure(1)
% imshow(hf)
% 
% figure(2)
% imshow(sf)
% 
% figure(3)
% imshow(vf)

%取图像的上半部分求极坐标特征
% center=[128 128];%极坐标原点
R=[0 16 32 48 64 80 96 112 128];%判断像素点落在哪个扇形区域
TH=[0 pi/12 pi/6 pi/4 pi/3 5*pi/12 pi/2 7*pi/12 2*pi/3 3*pi/4 5*pi/6 11*pi/12];
% 4*pi/5 13*pi/15 14*pi/15 pi];
pixh=zeros(12,256,8);
pixs=zeros(12,256,8);
pixv=zeros(12,256,8);
for i=1:256
    for j=1:128
        [theta,r]=cart2pol(i-128,abs(j-128));%求像素点对应的极坐标
        if r == 128
            indexR=8;
        elseif theta == pi
            indexTH=12;
        else
            indexR=length(R(r>=R));
            indexTH=length(TH(theta>=TH));
        end      
        if indexR <= 8 && indexR >= 1 && indexTH <= 12 && indexTH >= 1
            pixh(indexTH,i,indexR)=hf(i,j);
            pixs(indexTH,i,indexR)=sf(i,j);
            pixv(indexTH,i,indexR)=vf(i,j);
        end 
    end
end
%保存扇形区域的特征：均值和方差
featureh=zeros(2,96);
features=zeros(2,96);
featurev=zeros(2,96);
for dim=1:8
    valh=pixh(:,:,dim);
    vals=pixs(:,:,dim);
    valv=pixv(:,:,dim);
    for angle=1:12
        testh=valh(angle,:);
        tests=vals(angle,:);
        testv=valv(angle,:);
        testh=testh(testh~=0);
        tests=tests(tests~=0);
        testv=testv(testv~=0);
        featureh(1,(dim-1)*12+angle)=mean(testh);
        featureh(2,(dim-1)*12+angle)=var(testh);
%         featureh(3,(dim-1)*15+angle)=kurtosis(testh);
        features(1,(dim-1)*12+angle)=mean(tests);
        features(2,(dim-1)*12+angle)=var(tests);
%         features(3,(dim-1)*15+angle)=kurtosis(tests);
        featurev(1,(dim-1)*12+angle)=mean(testv);
        featurev(2,(dim-1)*12+angle)=var(testv);
%         featurev(3,(dim-1)*15+angle)=kurtosis(testv);
    end
end

% featureh=[featureh(1,:),featureh(2,:)];
% features=[features(1,:),features(2,:)];
% featurev=[featurev(1,:),featurev(2,:)];
% thetahsv=[featureh,features,featurev];