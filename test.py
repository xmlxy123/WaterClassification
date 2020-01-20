from numpy import *
from compiler.ast import flatten
import os
from sklearn.decomposition import PCA
from sklearn import neighbors
from sklearn import svm
from sklearn.linear_model import LogisticRegression

from sklearn.ensemble import RandomForestClassifier
# from sklearn.neighbors import KNeighborsClassifier
from sklearn.grid_search import GridSearchCV
from sklearn.cross_validation import cross_val_score
import pickle



# ICPR


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

testData = getData('E:\\water\\testAngleF576.csv')
trainData = getData('E:\\water\\trainAngleF576.csv')
# cleanData = getData('.\\cleanAngleAll.csv')
# pollutedData = getData('.\\pollutedAngleAll.csv')
# testData = testData[:,768:1344]
# trainData = trainData[:,768:1344]

trainPath = 'E:\\water\\train'
testPath = 'E:\\water\\test'
trainl = []
testl = []
# for file in os.listdir(trainPath):
#     fname = int(file.split('.')[0].split('_')[-1])
#     trainl.append(fname)
# for file in os.listdir(testPath):
#      fname = int(file.split('.')[0].split('_')[-1])
#      testl.append(fname)
# testLabel = array(testl)
# trainLabel = array(trainl)
# testDatac = testData[0:125, :]
# testDatap = testData[125:250, :]
# trainDatac = trainData[0:375, :]
# trainDatap = trainData[375:750, :]
# testLabelc = testLabel[0:125]
# testLabelp = testLabel[125:250]
# trainLabelc = trainLabel[0:375]
# trainLabelp = trainLabel[375:750]

testc = array([0] * 125)
testp = array([1] * 125)
testLabel = hstack((testc, testp))
trainc = array([0] * 375)
trainp = array([1] * 375)
trainLabel = hstack((trainc, trainp))

# def generateClass(c,label,data):
#     newData = []
#     newLabel = []
#     for i in range(label.__len__()):
#         if label[i] == c:
#             newData.append(data[i,:])
#             newLabel.append(label[i])
#     return array(newData),array(newLabel)
#
# train1,label1 = generateClass(8,trainl,trainData)
# train2,label2 = generateClass(9,trainl,trainData)
#
# trainData = vstack((train1,train2))
# trainLabel = hstack((label1,label2))
#
#
# test1,tlabel1 = generateClass(8,testl,testData)
# test2,tlabel2 = generateClass(9,testl,testData)
# print test1.shape
# print test2.shape
# testData = vstack((test1,test2))
# testLabel = hstack((tlabel1,tlabel2))



# log = LogisticRegression()
# log.fit(trainData, trainLabel)

# clf1 = svm.SVC(kernel = 'linear')
# clf1.fit(trainData, trainLabel)

knn = neighbors.KNeighborsClassifier(n_neighbors=20)
knn.fit(trainData,trainLabel)


# clf2 = RandomForestClassifier(n_estimators=10,max_features=math.sqrt(1), max_depth=None,min_samples_split=2)
# clf2.fit(trainData,trainLabel)



result1 = knn.predict(testData)
# for i in range(1, 51):
#     print result1[(i - 1) * 5:i * 5]
#     # print error
print result1
print testLabel
error = 0
errorp = 0
i = 0
count = 0
classnum = 0
for l in result1:
    # if testLabelc[i] == 1:
    #     if l == testLabel[i]:
    #         count = count + 1
    #     else:
    #         print l
    #     classnum = classnum + 1
    if l != testLabel[i]:
        # errorc = errorc + 1
        # if i < tlabel1.__len__():
        #     errorc = errorc + 1
        # else:
        #     errorp = errorp + 1
            error = error + 1
    i += 1
# print i
# print classnum
# print count
print error
# print errorp
print '%.2f%%' % ((1 - float(error) / float(len(testLabel))) * 100)