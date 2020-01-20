%function [opts] = Create_GaborF (ipts, par)
%
%
% This function aims to create the argumented Gabor feature.
% 
%   input
%         ipts.              input data structure
%              dat           3d image data matrix, each dat(:,:,i) is an (downsampled) 
%                            image matrix.
%         par.               input parameter structure
%              ds_w          the downsample image's width in Gabor
%              ds_h          the downsample image's heigth in Gabor
%              ke_w          Gabor kernel's width
%              ke_h          Gabor kernel's heigth
%              Kmax          Gabor kernel's para, default(pi/2)
%              f             Gabor kernel's para, default(sqrt(2))
%              sigma         Gabor kernel's para, default(pi or 1.5pi)
%              Gabornum      Gabor kernel's number
%
%  output
%        opts.              output data structure
%            gdat           Gabor feature of training data, each column is
%                           the argumented gabor feature vector of a sample
%--------------------------------------------------------------------------
%                           Note(Zhen Cui): every Gabor kernel spans a
%                           vector of ds_w*ds_h, and then concatenated the
%                           Gabornum thus vector.
%--------------------------------------------------------------------------
%
%  Copyright  Mike YANG, PolyU, Hong Kong
%  reference: Liu,C.,Wechsler,H.:Gabor Feature Based Classification Using the Enhanced Fisher
%  Linear Discriminant Model for Face Recognition IEEE IP 11 (2002)467–476.
%
function [opts]    =    Create_GaborF (ipts, par)

if mod(par.ke_w,2)~=1 || mod(par.ke_h,2)~=1
    error('The width and height of Gabor kernel should be odd number');
end

[ GaborReal, GaborImg ]  =  MakeAllGaborKernal( par.ke_h, par.ke_w ,par.Gabor_num,par.Kmax, par.f, par.sigma);

num = size(ipts.dat,3);%处理的图片数量
texture = zeros(num,48);

for i  =  1: num
    tic
    texture(i,:) = Gabor_Texture3(ipts.dat(:,:,i),GaborReal,GaborImg);
    toc
end

opts = reshape(texture,num/3,144);
end
