import pickle
import os
from sklearn import svm
from numpy import *

def generateClass(c, label, data):
    newData = []
    newLabel = []
    for i in range(label.__len__()):
        if label[i] == c:
            newData.append(data[i, :])
            newLabel.append(label[i])
    return array(newData), array(newLabel)

trainFeature = pickle.load(open('E:\\water\\AlexNet\\trainFeature.pkl', 'rb'))
testFeature = pickle.load(open('E:\\water\\AlexNet\\testFeature.pkl', 'rb'))
# trLabel = pickle.load(open('E:\\water\\AlexNet\\trainlabel.pkl', 'rb'))
# teLabel = pickle.load(open('E:\\water\\AlexNet\\testlabel.pkl', 'rb'))

trainData = []
testData = []

for f in testFeature:
    testData.append(f[0])
for r in trainFeature:
    trainData.append(r[0])

trainPath = '.\\train'
testPath = '.\\test'
trainl = []
testl = []
for file in os.listdir(trainPath):
    fname = int(file.split('.')[0].split('_')[-1])
    trainl.append(fname)
for file in os.listdir(testPath):
     fname = int(file.split('.')[0].split('_')[-1])
     testl.append(fname)
testLabel = array(testl)
trainLabel = array(trainl)


trainData = array(trainData)
testData = array(testData)
# print trainData.shape
# print testData.shape


testDatac = testData[0:125, :]
testDatap = testData[125:250, :]
trainDatac = trainData[0:375, :]
trainDatap = trainData[375:750, :]
testLabelc = testLabel[0:125]
testLabelp = testLabel[125:250]
trainLabelc = trainLabel[0:375]
trainLabelp = trainLabel[375:750]

# testc = array([0] * 125)
# testp = array([1] * 125)
# testLabel = hstack((testc, testp))
# trainc = array([0] * 375)
# trainp = array([1] * 375)
# trainLabel = hstack((trainc, trainp))

# train1, label1 = generateClass(6, trainl, trainData)
# train2, label2 = generateClass(7, trainl, trainData)
#
# trainData = vstack((train1, train2))
# trainLabel = hstack((label1, label2))
#
# test1, tlabel1 = generateClass(6, testl, testData)
# test2, tlabel2 = generateClass(7, testl, testData)
# print test1.shape
# print test2.shape
# testData = vstack((test1, test2))
# testLabel = hstack((tlabel1, tlabel2))

clf2 = svm.SVC(kernel='linear')
# clf2 = pickle.load(open('GOtrain.pkl','rb'))
clf2.fit(trainData, trainLabel)
result = clf2.predict(testData)
print result
print testLabel

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

errorc = 0
errorp = 0
i = 0
for l in result:
    if l != testLabel[i]:
        if i < tlabel1.__len__():
            errorc = errorc + 1
        else:
            errorp = errorp + 1
            # error = error + 1
    i = i + 1
print errorc
print errorp
print '%.2f%%' % ((1 - float(errorc + errorp) / float(len(testLabel))) * 100)
