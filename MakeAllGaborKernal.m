function [ GaborReal, GaborImg ] = MakeAllGaborKernal( GaborH, GaborW, Gabor_num,Kmax,f,sigma)
% GaborReal, [GaborH,GaborW,32] 32个Gabor模板实部
% GaborImg,  [GaborH,GaborW,32] 32个Gabor模板虚部
% 缺省输入前2个参数,后面参数 Kmax=2.5*pi/2, f=sqrt(2), sigma=1.5*pi;
% GaborH, GaborW, Gabor模板大小
% U,方向因子{0,1,2,3,4,5,6,7}
% V,大小因子{1,2,3,4}
% Kmax,f,sigma 其他参数

    
GaborReal = zeros( GaborH, GaborW, 32 );
GaborImg = zeros( GaborH, GaborW, 32 );
    
vnum=4;
unum=8;

if Gabor_num~=vnum*unum
    error('The Gabor num is 5 scales and 8 orientations!');
end
        
for v = 1 : vnum%尺度
    for u = 0 : (unum-1)
        [ GaborReal(:,:,(v-1)*8+u+1), GaborImg(:,:,(v-1)*8+u+1) ] = MakeGaborKernal( GaborH, GaborW, u, v, Kmax,f,sigma );
    end
end


