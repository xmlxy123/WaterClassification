import os
import cv2
import pickle
from numpy import *

path = 'E:/water/dtd/images/'
count = 1
for file in os.listdir(path):
    for f in os.listdir(path+file):
        fname = f.split('.')[0]
        # if file == 'canal':
        #     os.rename(os.path.join(path, file, f), os.path.join(path, file, fname + '_1' + ".jpg"))
        if file == 'studded':
            os.rename(os.path.join(path, file, f), os.path.join(path, file, fname + '_41' + ".png"))
        if file == 'swirly':
            os.rename(os.path.join(path, file, f), os.path.join(path, file, fname + '_42' + ".png"))
        if file == 'veined':
            os.rename(os.path.join(path, file, f), os.path.join(path, file, fname + '_43' + ".png"))
        # if file == 'pond':
        #     os.rename(os.path.join(path, file, f), os.path.join(path, file, fname + '_5' + ".jpg"))
        if file == 'waffled':
            os.rename(os.path.join(path, file, f), os.path.join(path, file, fname + '_44' + ".png"))
        if file == 'woven':
            os.rename(os.path.join(path, file, f), os.path.join(path, file, fname + '_45' + ".png"))
        # if file == 'stream':
        #     os.rename(os.path.join(path, file, f), os.path.join(path, file, fname + '_7' + ".jpg"))
        if file == 'wrinkled':
            os.rename(os.path.join(path, file, f), os.path.join(path, file, fname + '_46' + ".png"))
        # if file == 'deadanimals':
        #     os.rename(os.path.join(path, file, f), os.path.join(path, file, fname + '_6' + ".jpg"))
        if file == 'zigzagged':
            os.rename(os.path.join(path, file, f), os.path.join(path, file, fname + '_47' + ".png"))
        # if file == 'stained':
        #     os.rename(os.path.join(path, file, f), os.path.join(path, file, fname + '_38' + ".png"))
        # if file == 'stratified':
        #     os.rename(os.path.join(path, file, f), os.path.join(path, file, fname + '_39' + ".png"))
        # # if file == 'plastic':
        # #     os.rename(os.path.join(path, file, f), os.path.join(path, file, fname + '_13' + ".jpg"))
        # if file == 'striped':
        #     os.rename(os.path.join(path, file, f), os.path.join(path, file, fname + '_40' + ".png"))
        # if file == 'wool':
            # os.rename(os.path.join(path, file, f), os.path.join(path, file, fname + '_11' + ".png"))
    # if count <10:
    #     os.rename(os.path.join(path, file), os.path.join(path, "polluted_00"+str(count) + ".jpg"))
    # if count < 100 and count>=10:
    #     os.rename(os.path.join(path, file), os.path.join(path, "polluted_0"+str(count)+".jpg"))
    # if count >= 100:
    #      os.rename(os.path.join(path, file), os.path.join(path, "polluted_"+str(count) + ".jpg"))
    print count
    # print file
    count += 1

# def write_file_not_cover(file_path, file_content):
#     # father_dir = '/'.join(file_path.split('/')[0:-1])
#     # print father_dir
#     # if not os.path.exists(father_dir):
#     #     os.makedirs(father_dir)
#     file_object = open(file_path, 'a')
#     file_object.write(file_content)
#     file_object.close()
#
# def getPath(path):
#     f = []
#     for root, dirs, files in os.walk(path):
#         for file in files:
#             # if os.path.splitext(file)[1] == '.jpg':
#             f.append(os.path.join(root, file))
#     return f

# def generateLabel(path,file_path):
#     for p in path:
#         fileName = p.split('\\')[-1]
#         name = fileName.split('.')[0]
#         if 'clean' in name:
#             label = fileName + ' ' + '0' + '\n'
#             write_file_not_cover(file_path, label)
#         if 'polluted' in name:
#             label = fileName + ' ' + '1' + '\n'
#             write_file_not_cover(file_path, label)
#         print path.index(p)
#         print p
#
# if __name__ == '__main__':
#     filePath = getPath("E://water//Colored Brodatz")
#     print filePath
#     # src = cv2.imread('E:\\water\\disaster\\train\\flood_024_5.jpg')
#     # print src.shape
#     # cv2.imwrite('E:\\water\\disaster\\train\\flood_024_5.jpg',src)
#     i = 1
#     for p in filePath:
#         # src = cv2.imread(p)
#         fname = p.split('.')[0]
#         print fname
#         os.rename(p, os.path.join(fname + '_' + str(i) + ".tif"))
#         i+=1
#         # name1 = p.split('\\')[-1].split('.')[0].split('_')[-1]
#         # write_file_not_cover('E://water//disaster//trainLabel.csv', name1 + ',')
#         # print name1
#         # print name2
#         # name = name1 + '_' + name2 + '_1' + '.jpg'
#         # print name
#         # cv2.imwrite(name, src)
#         # if cc<10:
#         #     cv2.imwrite('clean' + '_' + '00'+str(cc) + '_2' + '.jpg', src)
#         # if cc>=10 and cc <100:
#         #     cv2.imwrite('clean' + '_' + '0'+str(cc) + '_2' + '.jpg', src)
#         # if cc >= 100:
#         #     cv2.imwrite('clean' + '_' +str(cc) + '_2' + '.jpg', src)
#         # cc+=1

# def getData(Path):
#     data = []
#     with open(Path, 'rb') as f:
#         for line in f.readlines():
#             line = line.strip('\n')
#             line = line.split(',')
#             # del line[-1]
#             data.append(map(float, line))
#     dataset = array(data)
#     return dataset
# def write_file_not_cover(file_path, file_content):
#     # father_dir = '/'.join(file_path.split('/')[0:-1])
#     # print father_dir
#     # if not os.path.exists(father_dir):
#     #     os.makedirs(father_dir)
#     file_object = open(file_path, 'a')
#     file_object.write(file_content)
#     file_object.close()
# # train = getData('.\\Now\\train1056.csv')
# test = getData('.\\NANRUI Frozen\\testFrozen1056.csv')
# # trainFeature = pickle.load(open('E:\\water\\Res152\\train152.pkl', 'rb'))
# testFeature = pickle.load(open('.\\NANRUI Frozen\\testFrozen1000.pkl', 'rb'))
#
# trainData = []
# testData = []
#
# for f in testFeature:
#     testData.append(f[0])
# # for r in trainFeature:
# #     trainData.append(r[0])
#
# # trainData = array(trainData)
# testData = array(testData)
#
# # train1 = getData('.\\trainVGG161000.csv')
# # test1 = getData('.\\testVGG161000.csv')
# # train1 = train1[:,768:1344]
# # train = train[:,768:]
# # test1 = test1[:,768:1344]
# # test = test[:,768:]
# # print trainData.shape
# # print train.shape
# # traina = hstack((trainData,train))
# testa = hstack((testData,test))
#
#
#
# for tf in testa:
#     for mm in tf:
#         write_file_not_cover('testFrozen2056.csv', str(mm) + ',')
#     write_file_not_cover('testFrozen2056.csv', '\n')
#     print tf
#
# # for tf in traina:
# #     for mm in tf:
# #         write_file_not_cover('trainResWavelets2056.csv', str(mm) + ',')
# #     write_file_not_cover('trainResWavelets2056.csv', '\n')
# #   print tf