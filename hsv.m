function [thetahsv]=hsv(path,GaborReal, GaborImg)
I = imread(path);
I=imresize(I,[256 256]);
% figure(1);
% imshow(I);
HSV=rgb2hsv(I);
H = HSV(:, :, 1);
S = HSV(:, :, 2);
V = HSV(:, :, 3);
tic
%%
%提取傅里叶变换后的纹理特征
% hf=fft2(H);%进行傅里叶变换
% sf=fft2(S);
% vf=fft2(V);
% hf=log(abs(fftshift(hf)));%对傅里叶变换后的图像进行象限转换，求复数的模，得到变换后的幅值
% sf=log(abs(fftshift(sf)));
% vf=log(abs(fftshift(vf)));
% %做个normalization
% hf=(hf-min(hf(:)))/(max(hf(:))-min(hf(:)));
% sf=(sf-min(sf(:)))/(max(sf(:))-min(sf(:)));
% vf=(vf-min(vf(:)))/(max(vf(:))-min(vf(:)));
% %取图像的上半部分求极坐标特征
% % center=[128 128];%极坐标原点
% R=[0 16 32 48 64 80 96 112 128];%判断像素点落在哪个扇形区域
% TH=[0 pi/12 pi/6 pi/4 pi/3 5*pi/12 pi/2 7*pi/12 2*pi/3 3*pi/4 5*pi/6 11*pi/12];
% % 4*pi/5 13*pi/15 14*pi/15 pi];
% pixh=zeros(12,256,8);
% pixs=zeros(12,256,8);
% pixv=zeros(12,256,8);
% for i=1:256
%     for j=1:128
%         [theta,r]=cart2pol(i-128,abs(j-128));%求像素点对应的极坐标
%         if r == 128
%             indexR=8;
%         elseif theta == pi
%             indexTH=12;
%         else
%             indexR=length(R(r>=R));
%             indexTH=length(TH(theta>=TH));
%         end      
%         if indexR <= 8 && indexR >= 1 && indexTH <= 12 && indexTH >= 1
%             pixh(indexTH,i,indexR)=hf(i,j);
%             pixs(indexTH,i,indexR)=sf(i,j);
%             pixv(indexTH,i,indexR)=vf(i,j);
%         end 
%     end
% end
% %保存扇形区域的特征：均值和方差
% featureh=zeros(2,96);
% features=zeros(2,96);
% featurev=zeros(2,96);
% for dim=1:8
%     valh=pixh(:,:,dim);
%     vals=pixs(:,:,dim);
%     valv=pixv(:,:,dim);
%     for angle=1:12
%         testh=valh(angle,:);
%         tests=vals(angle,:);
%         testv=valv(angle,:);
%         testh=testh(testh~=0);
%         tests=tests(tests~=0);
%         testv=testv(testv~=0);
%         featureh(1,(dim-1)*12+angle)=mean(testh);
%         featureh(2,(dim-1)*12+angle)=var(testh);
% %         featureh(3,(dim-1)*15+angle)=kurtosis(testh);
%         features(1,(dim-1)*12+angle)=mean(tests);
%         features(2,(dim-1)*12+angle)=var(tests);
% %         features(3,(dim-1)*15+angle)=kurtosis(tests);
%         featurev(1,(dim-1)*12+angle)=mean(testv);
%         featurev(2,(dim-1)*12+angle)=var(testv);
% %         featurev(3,(dim-1)*15+angle)=kurtosis(testv);
%     end
% end
% 
% featureh=[featureh(1,:),featureh(2,:)];
% features=[features(1,:),features(2,:)];
% featurev=[featurev(1,:),featurev(2,:)];
% thetahsv=[featureh,features,featurev];


%%
%提取伽柏小波特征

texture = zeros(3,96);
texture(1,:) = Gabor_Texture3(H,GaborReal,GaborImg);
texture(2,:) = Gabor_Texture3(S,GaborReal,GaborImg);
texture(3,:) = Gabor_Texture3(V,GaborReal,GaborImg);
texture = reshape(texture,1,288);
% texture=Gabor_Texture3(H,GaborReal,GaborImg);

%%
%提取梯度方向特征
[Hx,Hy]=gradient(H);%获得H,S,V三个方向上的x,y梯度变化
[Sx,Sy]=gradient(S);
[Vx,Vy]=gradient(V);

lamda1H=zeros(16,16);
lamda2H=zeros(16,16);
lamda1S=zeros(16,16);
lamda2S=zeros(16,16);
lamda1V=zeros(16,16);
lamda2V=zeros(16,16);

for j=1:16 %纵向分块
    for i=1:16
        patchx=Hx((i-1)*16+1:i*16,(j-1)*16+1:j*16);
        patchy=Hy((i-1)*16+1:i*16,(j-1)*16+1:j*16);
        patchx2=patchx.^2;
        patchy2=patchy.^2;
        patchxy=patchx.*patchy;
        %计算ST矩阵
        t1=sum(patchx2(:));
        t4=sum(patchy2(:));
        t2=sum(patchxy(:));
        t3=sum(patchxy(:));
        ST=[t1,t2;t3,t4];
        D=eig(ST);
        lamda1H(i,j)=D(1);
        lamda2H(i,j)=D(2);
%         DC=(double(D(1)-D(2))\double(D(1)+D(2))).^2
    end
end

for j=1:16 %纵向分块
    for i=1:16
        patchx=Sx((i-1)*16+1:i*16,(j-1)*16+1:j*16);
        patchy=Sy((i-1)*16+1:i*16,(j-1)*16+1:j*16);
        patchx2=patchx.^2;
        patchy2=patchy.^2;
        patchxy=patchx.*patchy;
        %计算ST矩阵
        t1=sum(patchx2(:));
        t4=sum(patchy2(:));
        t2=sum(patchxy(:));
        t3=sum(patchxy(:));
        ST=[t1,t2;t3,t4];
        D=eig(ST);
        lamda1S(i,j)=D(1);
        lamda2S(i,j)=D(2);
%         DC=(double(D(1)-D(2))\double(D(1)+D(2))).^2
    end
end

for j=1:16 %纵向分块
    for i=1:16
        patchx=Vx((i-1)*16+1:i*16,(j-1)*16+1:j*16);
        patchy=Vy((i-1)*16+1:i*16,(j-1)*16+1:j*16);
        patchx2=patchx.^2;
        patchy2=patchy.^2;
        patchxy=patchx.*patchy;
        %计算ST矩阵
        t1=sum(patchx2(:));
        t4=sum(patchy2(:));
        t2=sum(patchxy(:));
        t3=sum(patchxy(:));
        ST=[t1,t2;t3,t4];
        D=eig(ST);
        lamda1V(i,j)=D(1);
        lamda2V(i,j)=D(2);
%         DC=(double(D(1)-D(2))\double(D(1)+D(2))).^2
    end
end

% lamda1H=abs(lamda1H);
% lamda2H=abs(lamda2H);
% lamda1S=abs(lamda1S);
% lamda2S=abs(lamda2S);
% lamda1V=abs(lamda1V);
% lamda2V=abs(lamda2V);

% figure(1);
% imshow(lamda1H);
% figure(2);
% imshow(lamda2H);
% figure(3);
% imshow(lamda1S);
% figure(4);
% imshow(lamda2S);
% figure(5);
% imshow(lamda1V);
% figure(6);
% imshow(lamda2V);


thetah1=zeros(11,256);
thetas1=zeros(11,256);
thetav1=zeros(11,256);

sigma = [1.25^0 1.25^1 1.25^2 1.25^3 1.25^4 1.25^5 1.25^6 1.25^7 1.25^8 1.25^9 1.25^10];
for s=1:11
    Gx=GuassianX(sigma(s));
    Gy=GuassianY(sigma(s));
    hx=imfilter(lamda1H,Gx);
    hy=imfilter(lamda2H,Gy);
    sx=imfilter(lamda1S,Gx);
    sy=imfilter(lamda2S,Gy);
    vx=imfilter(lamda1V,Gx);
    vy=imfilter(lamda2V,Gy);
    for i=1:16
        for j=1:16
            if hx(i,j)>0 && hy(i,j)>0
                thetah=atan(hx(i,j)/hy(i,j))+pi;
            
            elseif hx(i,j)<0 && hy(i,j)>0
                thetah=atan(hx(i,j)/hy(i,j))+pi*2;
            
            elseif hx(i,j)<0 && hy(i,j)<0
                thetah=atan(hx(i,j)/hy(i,j));
            
            elseif hx(i,j)>0 && hy(i,j)<0
                thetah=atan(hx(i,j)/hy(i,j))+pi;
            
            else thetah = 0;
            end
            if sx(i,j)>0 && sy(i,j)>0
                thetas=atan(sx(i,j)/sy(i,j))+pi;
            
            elseif sx(i,j)<0 && sy(i,j)>0
                thetas=atan(sx(i,j)/sy(i,j))+pi*2;
            
            elseif sx(i,j)<0 && sy(i,j)<0
                thetas=atan(sx(i,j)/sy(i,j));
            
            elseif sx(i,j)>0 && sy(i,j)<0
                thetas=atan(sx(i,j)/sy(i,j))+pi;
            else thetas = 0;
            end
            if vx(i,j)>0 && vy(i,j)>0
                thetav=atan(vx(i,j)/vy(i,j))+pi;
            
            elseif vx(i,j)<0 && vy(i,j)>0
                thetav=atan(vx(i,j)/vy(i,j))+pi*2;
            
            elseif vx(i,j)<0 && vy(i,j)<0
                thetav=atan(vx(i,j)/vy(i,j));
            
            elseif vx(i,j)>0 && vy(i,j)<0
                thetav=atan(vx(i,j)/vy(i,j))+pi;
            else thetav = 0;
            end
            thetah1(s,j+(i-1)*16) = thetah;
            thetas1(s,j+(i-1)*16) = thetas;
            thetav1(s,j+(i-1)*16) = thetav;
        end
    end
end 

numh = zeros(16,256);
for n=1:256
   for i=1:11
        if thetah1(i,n)>0 && thetah1(i,n)<(pi/8)
            numh(1,n) = numh(1,n)+1;
        end
        if thetah1(i,n)>(pi/8) && thetah1(i,n)<(pi/4)
            numh(2,n) = numh(2,n)+1;
        end
        if thetah1(i,n)>(pi/4) && thetah1(i,n)<(3*pi/8)
            numh(3,n) = numh(3,n)+1;
        end
        if thetah1(i,n)>(3*pi/8) && thetah1(i,n)<(pi/2)
            numh(4,n) = numh(4,n)+1;
        end
        if thetah1(i,n)>(pi/2) && thetah1(i,n)<(5*pi/8)
            numh(5,n) = numh(5,n)+1;
        end
        if thetah1(i,n)>(5*pi/8) && thetah1(i,n)<(3*pi/4)
            numh(6,n) = numh(6,n)+1;
        end
        if thetah1(i,n)>(3*pi/4) && thetah1(i,n)<(7*pi/8)
            numh(7,n) = numh(7,n)+1;
        end
        if thetah1(i,n)>(7*pi/8) && thetah1(i,n)<pi
            numh(8,n) = numh(8,n)+1;
        end
        if thetah1(i,n)>pi && thetah1(i,n)<(9*pi/8)
            numh(9,n) = numh(9,n)+1;
        end
        if thetah1(i,n)>(9*pi/8) && thetah1(i,n)<(5*pi/4)
            numh(10,n) = numh(10,n)+1;
        end
        if thetah1(i,n)>(5*pi/4) && thetah1(i,n)<(11*pi/8)
            numh(11,n) = numh(11,n)+1;
        end
        if thetah1(i,n)>(11*pi/8) && thetah1(i,n)<(3*pi/2)
            numh(12,n) = numh(12,n)+1;
        end
        if thetah1(i,n)>(3*pi/2) && thetah1(i,n)<(13*pi/8)
            numh(13,n) = numh(13,n)+1;
        end
        if thetah1(i,n)>(13*pi/8) && thetah1(i,n)<(7*pi/4)
            numh(14,n) = numh(14,n)+1;
        end
        if thetah1(i,n)>(7*pi/4) && thetah1(i,n)<(15*pi/8)
            numh(15,n) = numh(15,n)+1;
        end
        if thetah1(i,n)>(15*pi/8) && thetah1(i,n)<(2*pi)
            numh(16,n) = numh(16,n)+1;
        end
    end
end
[~,Ind_row]=max(numh);
h=Ind_row;

nums = zeros(16,256);
for n=1:256
   for i=1:11
        if thetas1(i,n)>0 && thetas1(i,n)<(pi/8)
            nums(1,n) = nums(1,n)+1;
        end
        if thetas1(i,n)>(pi/8) && thetas1(i,n)<(pi/4)
            nums(2,n) = nums(2,n)+1;
        end
        if thetas1(i,n)>(pi/4) && thetas1(i,n)<(3*pi/8)
            nums(3,n) = nums(3,n)+1;
        end
        if thetas1(i,n)>(3*pi/8) && thetas1(i,n)<(pi/2)
            nums(4,n) = nums(4,n)+1;
        end
        if thetas1(i,n)>(pi/2) && thetas1(i,n)<(5*pi/8)
            nums(5,n) = nums(5,n)+1;
        end
        if thetas1(i,n)>(5*pi/8) && thetas1(i,n)<(3*pi/4)
            nums(6,n) = nums(6,n)+1;
        end
        if thetas1(i,n)>(3*pi/4) && thetas1(i,n)<(7*pi/8)
            nums(7,n) = nums(7,n)+1;
        end
        if thetas1(i,n)>(7*pi/8) && thetas1(i,n)<pi
            nums(8,n) = nums(8,n)+1;
        end
        if thetas1(i,n)>pi && thetas1(i,n)<(9*pi/8)
            nums(9,n) = nums(9,n)+1;
        end
        if thetas1(i,n)>(9*pi/8) && thetas1(i,n)<(5*pi/4)
            nums(10,n) = nums(10,n)+1;
        end
        if thetas1(i,n)>(5*pi/4) && thetas1(i,n)<(11*pi/8)
            nums(11,n) = nums(11,n)+1;
        end
        if thetas1(i,n)>(11*pi/8) && thetas1(i,n)<(3*pi/2)
            nums(12,n) = nums(12,n)+1;
        end
        if thetas1(i,n)>(3*pi/2) && thetas1(i,n)<(13*pi/8)
            nums(13,n) = nums(13,n)+1;
        end
        if thetas1(i,n)>(13*pi/8) && thetas1(i,n)<(7*pi/4)
            nums(14,n) = nums(14,n)+1;
        end
        if thetas1(i,n)>(7*pi/4) && thetas1(i,n)<(15*pi/8)
            nums(15,n) = nums(15,n)+1;
        end
        if thetas1(i,n)>(15*pi/8) && thetas1(i,n)<(2*pi)
            nums(16,n) = nums(16,n)+1;
        end
    end
end
[~,Ind_row]=max(nums);
s=Ind_row;

numv = zeros(16,256);
for n=1:256
   for i=1:11
        if thetav1(i,n)>0 && thetav1(i,n)<(pi/8)
            numv(1,n) = numv(1,n)+1;
        end
        if thetav1(i,n)>(pi/8) && thetav1(i,n)<(pi/4)
            numv(2,n) = numv(2,n)+1;
        end
        if thetav1(i,n)>(pi/4) && thetav1(i,n)<(3*pi/8)
            numv(3,n) = numv(3,n)+1;
        end
        if thetav1(i,n)>(3*pi/8) && thetav1(i,n)<(pi/2)
            numv(4,n) = numv(4,n)+1;
        end
        if thetav1(i,n)>(pi/2) && thetav1(i,n)<(5*pi/8)
            numv(5,n) = numv(5,n)+1;
        end
        if thetav1(i,n)>(5*pi/8) && thetav1(i,n)<(3*pi/4)
            numv(6,n) = numv(6,n)+1;
        end
        if thetav1(i,n)>(3*pi/4) && thetav1(i,n)<(7*pi/8)
            numv(7,n) = numv(7,n)+1;
        end
        if thetav1(i,n)>(7*pi/8) && thetav1(i,n)<pi
            numv(8,n) = numv(8,n)+1;
        end
        if thetav1(i,n)>pi && thetav1(i,n)<(9*pi/8)
            numv(9,n) = numv(9,n)+1;
        end
        if thetav1(i,n)>(9*pi/8) && thetav1(i,n)<(5*pi/4)
            numv(10,n) = numv(10,n)+1;
        end
        if thetav1(i,n)>(5*pi/4) && thetav1(i,n)<(11*pi/8)
            numv(11,n) = numv(11,n)+1;
        end
        if thetav1(i,n)>(11*pi/8) && thetav1(i,n)<(3*pi/2)
            numv(12,n) = numv(12,n)+1;
        end
        if thetav1(i,n)>(3*pi/2) && thetav1(i,n)<(13*pi/8)
            numv(13,n) = numv(13,n)+1;
        end
        if thetav1(i,n)>(13*pi/8) && thetav1(i,n)<(7*pi/4)
            numv(14,n) = numv(14,n)+1;
        end
        if thetav1(i,n)>(7*pi/4) && thetav1(i,n)<(15*pi/8)
            numv(15,n) = numv(15,n)+1;
        end
        if thetav1(i,n)>(15*pi/8) && thetav1(i,n)<(2*pi)
            numv(16,n) = numv(16,n)+1;
        end
    end
end
[~,Ind_row]=max(numv);
v=Ind_row;


% numh1 = sum(numh,2);
% nums1 = sum(nums,2);
% numv1 = sum(numv,2);
% figure
% bar([numh1 nums1 numv1], 'stack')
% % axis([0 3 0 30])
% % set(gca, 'XTicklabel', {'标题1', '标题2'})
% ylabel('Pixel Numbers');
% xlabel('Orientation');
% legend('H Channel', 'S Channel', 'V Channel');
% 
% toc
% 
thetahsv=[texture,h,s,v];
% thetahsv=texture;
% thetahsv=[featureh(1,:);features(1,:);featurev(1,:);featureh(2,:);features(2,:);featurev(2,:)];
end


