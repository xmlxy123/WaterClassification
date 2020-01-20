% clear all;
tic
Gaborsetting;
[ GaborReal, GaborImg ]  =  MakeAllGaborKernal( par.ke_h, par.ke_w ,par.Gabor_num,par.Kmax, par.f, par.sigma);

% trainPath = 'E:\water\train\clean water';
% trainPath2 = 'E:\water\train\polluted water';
testPath = 'E:\water\KTH_TIPS\test';
% trainDir = dir([trainPath,'\*.jpg']);
% trainDir2 = dir([trainPath2,'\*.jpg']);
testDir = dir([testPath,'\\*.png']);
length(testDir)

% fullfile(testPath,testDir(514).name)
testAngle = zeros(202,1056);
for i = 1 : length(testDir)
%     subTest = fullfile(testPath,testDir(i).name);
%     subTestDir = dir([subTest,'\*.jpg']);
%     for p = 1:length(subTestDir)
        testAngle(i,:) = hsv(fullfile(testPath,testDir(i).name),GaborReal, GaborImg);
        disp(['测试集处理完第',num2str(i),'张图像: ',testDir(i).name]);
%     end
end
% for i = 333 : length(testDir)
% %     subTest = fullfile(testPath,testDir(i).name);
% %     subTestDir = dir([subTest,'\*.jpg']);
% %     for p = 1:length(subTestDir)
%         testAngle(i-1,:) = hsv(fullfile(testPath,testDir(i).name),GaborReal, GaborImg);
%         disp(['测试集处理完第',num2str(i),'张图像: ',testDir(i).name]);
% %     end
% end
% trainAngleClean = zeros(375,1632);
% for i = 190 : 199
% %     subTrain = fullfile(trainPath,trainDir(i).name);
% %     subTrainDir = dir([subTrain,'\*.jpg']);
% %     for p = 1:length(subTrainDir)
%         trainAngleClean(i,:) = hsv(fullfile(trainPath,trainDir(i).name),GaborReal,GaborImg);
%         disp(['训练集处理完第',num2str(i),'张图像:',trainDir(i).name]);
% %     end
% end

% trainAnglePolluted = zeros(375,1632);
% for i = 217 : length(trainDir2)
% %     subTrain = fullfile(trainPath,trainDir(i).name);
% %     subTrainDir = dir([subTrain,'\*.jpg']);
% %     for p = 1:length(subTrainDir)
%         trainAnglePolluted(i,:) = hsv(fullfile(trainPath2,trainDir2(i).name),GaborReal,GaborImg);
%         disp(['训练集第',num2str(i),'张图像:',trainDir2(i).name]);
% %     end
% end

% pollutedPath = 'E:\water\gg';
% cleanPath = 'E:\water\clean water';
% pollutedDir = dir([pollutedPath,'\*.jpg']);
% cleanDir = dir([cleanPath,'\*.jpg']);

% pollutedNum = length(pollutedDir);
% cleanNum = length(cleanDir);

% po = randperm(pollutedNum);
% cl = randperm(cleanNum);

% testcl = cl(1:floor(cleanNum/4));
% testpo = po(1:floor(pollutedNum/4));

% for tcl = 1:length(testcl)
%     movefile(fullfile(cleanPath,cleanDir(testcl(tcl)).name),'test\clean water');
% end

% for tpo = 1:length(testpo)
%     movefile(fullfile(pollutedPath,pollutedDir(testpo(tpo)).name),'test\polluted water');
% end

% load('testAngle.mat','testAngle');
% load('trainAngleClean116.mat','trainAngleClean');
% train1 = trainAngleClean;
% load('trainAngleClean117.mat','trainAngleClean');
% train2 = trainAngleClean;
% load('trainAngleClean118-178.mat','trainAngleClean');
% train3 = trainAngleClean;
% load('trainAngleClean179-189.mat','trainAngleClean');
% train4 = trainAngleClean;
% load('trainAngleClean190-199.mat','trainAngleClean');
% train5 = trainAngleClean;
% load('trainAngleClean200-222.mat','trainAngleClean');
% train6 = trainAngleClean;
% load('trainAngleClean223-250.mat','trainAngleClean');
% train7 = trainAngleClean;
% load('trainAngleClean251-300.mat','trainAngleClean');
% train8 = trainAngleClean;
% load('trainAngleClean.mat','trainAngleClean');
% train9 = trainAngleClean;
% load('trainAnglePolluted.mat','trainAnglePolluted');
% train10 = trainAnglePolluted;
% 
% train1 = train1(1:116,:);
% train2 = train2(117,:);
% train3 = train3(118:178,:);
% train4 = train4(179:189,:);
% train5 = train5(190:199,:);
% train6 = train6(200:222,:);
% train7 = train7(223:250,:);
% train8 = train8(251:300,:);
% train9 = train9(301:375,:);
% 
% trainAngle = [train9;train10];

csvwrite('E:\water\KTH_TIPS\test1056.csv',testAngle);
% csvwrite('trainAngleNew.csv',trainAngle);
toc