
% Gaborforfolder.m

clear all;
close all;

%%
Gaborsetting;
%% get original img data
tr_dir=uigetdir('select the data sets...');
tr_dir
% [priPath,dset]=priorPath(tr_dir);
[sfname,spath]=uiputfile('.csv','save file','gabordata');

img_dir = dir([tr_dir,'\*.jpg']);
img_num = length(img_dir);
% img_num = img_num*3;%´æ´¢ÈýÍ¨µÀÍ¼Ïñ

names=cell(1,img_num*3);

for ii=1:img_num
    fname=img_dir(ii).name;
    imgdata=imread([tr_dir,'\',fname]);
    imgdata = imresize(imgdata,[256 256]);
    HSV=rgb2hsv(imgdata);
    H = HSV(:, :, 1);
    S = HSV(:, :, 2);
    V = HSV(:, :, 3);
    if ii==1
        [h,w]=size(H);
        data=zeros(h,w,img_num*3);
    end
    data(:,:,ii)=H;
    data(:,:,ii+1)=S;
    data(:,:,ii+2)=V;
    names{ii}=strcat(fname,'H');
    names{ii+1}=strcat(fname,'S');
    names{ii+2}=strcat(fname,'V');
    
end

%% Gabor
ipts.dat=data;
clear data;

data = Create_GaborF (ipts, par);
size(data)

save(fullfile(spath,sfname),'data');

clear all;
close all;