function [GaborReal, GaborImg] = MakeGaborKernal(GaborH, GaborW, U, V, Kmax,f,sigma )
% function [GaborReal, GaborImg] = MakeGaborKernal[GaborH, GaborW, U, V]
% �������� Gabor ��
% GaborReal: ��ʵ�� GaborImg: �鲿
% GaborH,GaborW: Gabor���� �߿�.
% U,V: ���� ��С orientation and scale
%            ||Ku,v||^2
% G(Z) = ---------------- exp(-||Ku,v||^2 * Z^2)/(2*sigma*sigma)(exp(i*Ku,v*Z)-exp(-sigma*sigma/2))
%          sigma*sigma

HarfH = fix(GaborH/2);%���㷽��ȡ����GaborH=GaborW=11 
HarfW = fix(GaborW/2);

Qu = pi*U/8;%�൱��thetak
sqsigma = sigma*sigma;
% Kv = 2.5*pi*(2^(-(V+2)/2));
Kv = Kmax/(f^V);
 
postmean = exp(-sqsigma/2);

for j = -HarfH : HarfH%-5 5
    for i =  -HarfW : HarfW%-5 5
      
        tmp1 = exp(-(Kv*Kv*(j*j+i*i)/(2*sqsigma)));
        tmp2 = cos(Kv*cos(Qu)*i+Kv*sin(Qu)*j) - postmean;
  %      tmp3 = sin(Kv*cos(Qu)*i+Kv*sin(Qu)*j) - exp(-sqsigma/2);
        tmp3 = sin(Kv*cos(Qu)*i+Kv*sin(Qu)*j);
       
        GaborReal(j+HarfH+1, i+HarfW+1) = Kv*Kv*tmp1*tmp2/sqsigma;%11*11
        GaborImg(j+HarfH+1, i+HarfW+1) = Kv*Kv*tmp1*tmp3/sqsigma;
    end
end