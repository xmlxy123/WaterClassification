import pickle
import os
from sklearn import svm
from numpy import *

def getData(Path):
    data = []
    with open(Path, 'rb') as f:
        for line in f.readlines():
            line = line.strip('\n')
            line = line.split(',')
            # del line[-1]
            data.append(map(double, line))
    dataset = array(data)
    return dataset

def write_file_not_cover(file_path, file_content):
    # father_dir = '/'.join(file_path.split('/')[0:-1])
    # print father_dir
    # if not os.path.exists(father_dir):
    #     os.makedirs(father_dir)
    file_object = open(file_path, 'a')
    file_object.write(file_content)
    file_object.close()

trainFeature = pickle.load(open('E:\\water\\Res152\\train152_1.pkl', 'rb'))
# testFeature = pickle.load(open('E:\\water\\Colored Brodatz\\testColor1000.pkl', 'rb'))
# trainData1 = getData('E:\\water\\dtd\\testDTD1056.csv')
# trainData2 = getData('E:\\water\\dtd\\trainDTD1056_2.csv')
# trainData3 = getData('E:\\water\\dtd\\trainDTD1056_3.csv')
# testData1 = getData('E:\\water\\Colored Brodatz\\testColor1056.csv')
#
# teLabel = pickle.load(open('E:\\water\\Res152\\test152_1.pkl', 'rb'))
# trLabel = pickle.load(open('E:\\water\\KTH_TIPS\\trainTIPSlabel.pkl', 'rb'))

trainData = []
testData = []
testLabel=[]
trainLabel=[]

# for f in testFeature:
#     testData.append(f[0])
for r in trainFeature:
    trainData.append(r[0])

# print testData.__len__()
# print testData1.__len__()
#
# for f in teLabel:
#     testLabel.append(f[0])
#     print f
# for f in trLabel:
#     trainLabel.append(f[0])
# print testLabel
# for i in testLabel:
#     write_file_not_cover('E:\\water\\Res152\\test152_1.csv',str(i)+',')

# testD = hstack((testData1,testData))
# temp=vstack((trainData1,trainData2[1410:][:]))
# a = vstack((temp,trainData3[2820:][:]))
# trainD=hstack((trainData1,trainData))
# print trainD.shape
i=0
for tf in trainData:
    for mm in tf:
        write_file_not_cover('E:\\water\\Res152\\train152_1.csv', str(mm) + ',')
    write_file_not_cover('E:\\water\\Res152\\train152_1.csv', '\n')
    print tf
    i+=1
    print i



# trainPath = '.\\train'
# testPath = '.\\test'
# trainl = []
# testl = []
# for file in os.listdir(trainPath):
#     fname = int(file.split('.')[0].split('_')[-1])
#     trainl.append(fname)
# for file in os.listdir(testPath):
#      fname = int(file.split('.')[0].split('_')[-1])
#      testl.append(fname)
# testLabel = array(testl)
# trainLabel = array(trainl)

# testc = array([0] * 20)
# testp = array([1] * 20)
# testLabel = hstack((testc, testp))
# trainc = array([0] * 375)
# trainp = array([1] * 375)
# trainLabel = hstack((trainc, trainp))
#
#
# trainData = array(trainData)
# testData = array(testData)
#
# testDatac = testData[0:125, :]
# testDatap = testData[125:250, :]
# trainDatac = trainData[0:375, :]
# trainDatap = trainData[375:750, :]
# testLabelc = testLabel[0:125]
# testLabelp = testLabel[125:250]
# trainLabelc = trainLabel[0:375]
# trainLabelp = trainLabel[375:750]
#
#
# clf2 = svm.SVC(kernel='poly')
# # clf2 = pickle.load(open('GOtrain.pkl','rb'))
# clf2.fit(trainD, trainLabel)
# result = clf2.predict(testD)
# print result
# print testLabel


# i = 0
# count = 0
# classnum = 0
# errorc=0
# errorp=0
# for l in result:
#     if testLabelp[i] == 10:
#         if l == testLabelp[i]:
#             count += 1
#         else:
#             print l
#         classnum += 1
#     # if l != testLabelc[i]:
#     #     if i < 125:
#     #         errorc = errorc + 1
#     #     else:
#     #         errorp = errorp + 1
#     #         # error = error + 1
#     i += 1
# # print i
# print classnum
# print count


# errorc = 0
# errorp = 0
# i = 0
# error=0
# for l in result:
#     if l != testLabel[i]:
        # if i < 20:
        #     errorc = errorc + 1
        # else:
        #     errorp = errorp + 1
        #     error = error + 1
    # i = i + 1
# print errorc
# print errorp
# print '%.2f%%' % ((1 - float(error) / float(len(testLabel))) * 100)
