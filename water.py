from numpy import *
import time
import random
from collections import Counter
from compiler.ast import flatten
import os
from sklearn.decomposition import PCA
from sklearn import neighbors
from sklearn import svm
from sklearn.grid_search import GridSearchCV
from sklearn.cross_validation import cross_val_score
import pickle

def write_file_not_cover(file_path, file_content):
    # father_dir = '/'.join(file_path.split('/')[0:-1])
    # print father_dir
    # if not os.path.exists(father_dir):
    #     os.makedirs(father_dir)
    file_object = open(file_path, 'a')
    file_object.write(file_content)
    file_object.close()

def getData(Path):
    data = []
    with open(Path, 'rb') as f:
        for line in f.readlines():
            line = line.strip('\n')
            line = line.split(',')
            del line[-1]
            data.append(map(float, line))
    dataset = array(data)
    return dataset

def calculateMeanF1(dataset):
    t1 = dataset[:, 0:256]
    mean1 = mean(t1, axis=1)
    mean1 = array(reshape(mean1, (mean1.size, 1)))
    t2 = dataset[:, 256:512]
    mean2 = mean(t2, axis=1)
    mean2 = array(reshape(mean2, (mean2.size, 1)))
    t3 = dataset[:, 512:768]
    mean3 = mean(t3, axis=1)
    mean3 = array(reshape(mean3, (mean3.size, 1)))
    dataF1 = hstack((t1, t2, t3, mean1, mean2, mean3))
    return dataF1


def calculateMeanF3(dataset):
    t1 = dataset[:, 768:864]
    mean1 = mean(t1, axis=1)
    mean1 = array(reshape(mean1, (mean1.size, 1)))
    t2 = dataset[:, 864:960]
    mean2 = mean(t2, axis=1)
    mean2 = array(reshape(mean2, (mean2.size, 1)))
    t3 = dataset[:, 960:1055]
    mean3 = mean(t3, axis=1)
    mean3 = array(reshape(mean3, (mean3.size, 1)))
    dataF3 = hstack((t1, t2, t3, mean1, mean2, mean3))
    return dataF3

def getLabel(path):
    testl = []
    for file in os.listdir(path):
        fname = int(file.split('.')[0].split('_')[-1])
        testl.append(fname)
    testLabel = array(testl)
    return testLabel

def dataEnhancement(data, label):
    dic = {}
    for item in label:
        if item in dic.keys():
            dic[item] += 1
        else:
            dic[item] = 1
    # labelNums = zeros((dic.keys().__len__(), 2))
    maxLabel = max(dic, key=lambda x: dic[x])
    maxValue = float(dic[maxLabel])

    addData = []
    addLabel = []

    for key in dic:
        keyIndex = []
        if maxValue / dic[key] > 1:
            for index, value in enumerate(label):
                if value == key:
                    keyIndex.append(index)

            select = int(maxValue % dic[key])

            if maxValue // dic[key] == 1:
                dataIndex = random.sample(keyIndex, select)
                for i in dataIndex:
                    addData.append(data[i, :])
                    addLabel.append(key)
            else:
                cycle = int((maxValue - dic[key]) // dic[key])
                for c in range(cycle):
                    for k in keyIndex:
                        addData.append(data[k, :])
                        addLabel.append(key)
                dataIndex = random.sample(keyIndex, select)
                for i in dataIndex:
                    addData.append(data[i, :])
                    addLabel.append(key)
    addData = array(addData)
    addLabel = array(addLabel)
    newData = vstack((data, addData))
    newLabel = hstack((label, addLabel))

    return newData, newLabel



if __name__ == '__main__':
    start = time.clock()
    testData = getData('.\\test1056.csv')
    trainData = getData('.\\train1056.csv')
    print testData.shape

    trainF1 = calculateMeanF1(trainData)
    testF1 = calculateMeanF1(testData)
    trainF1c = trainF1[0:375, :]
    trainF1p = trainF1[375:750, :]
    testF1c = testF1[0:125, :]
    testF1p = testF1[125:250, :]

    trainF3 = calculateMeanF3(trainData)
    testF3 = calculateMeanF3(testData)
    trainF3c = trainF3[0:375, :]
    trainF3p = trainF3[375:750, :]
    testF3c = testF3[0:125, :]
    testF3p = testF3[125:250, :]

    trainData = hstack((trainF1, trainF3))

    testData = hstack((testF1, testF3))
    for tf in trainData:
        for mm in tf:
            write_file_not_cover('train1056New.csv', str(mm)+',')
        write_file_not_cover('train1056New.csv', '\n')
        print tf
    trainDatac = trainData[0:375, :]
    trainDatap = trainData[375:750, :]
    testDatac = testData[0:125, :]
    testDatap = testData[125:250, :]

    trainLabel = getLabel('.\\train')
    testLabel = getLabel('.\\test')

    testLabelc = testLabel[0:125]
    testLabelp = testLabel[125:250]
    trainLabelc = trainLabel[0:375]
    trainLabelp = trainLabel[375:750]

    print type(trainLabel)
    print trainF3

    trainF3, newtrainLabel = dataEnhancement(trainF3, trainLabel)
    print type(newtrainLabel)
    print newtrainLabel
    # trainF1, nn = dataEnhancement(trainF1, trainLabel)
    # trainLabel = newtrainLabel

    # clf1 = svm.SVC(kernel='linear')
    # clf1.fit(trainF3, trainLabel)
    # result1 = clf1.predict(trainF3)
    # error1 = 0
    # j = 0
    # for l in result1:
    #     if l != trainLabel[j]:
    #         error1 += 1
    #     j += 1
    # print 'train3 done! error1 = ' + str(error1)
    # accuracy1 = 1 - float(error1) / float(len(trainLabel))
    # print accuracy1
    #
    # clf2 = svm.SVC()
    # clf2.fit(trainF1, trainLabel)
    # result2 = clf2.predict(trainF1)
    # error2 = 0
    # j = 0
    # for l in result2:
    #     if l != trainLabel[j]:
    #         error2 += 1
    #     j += 1
    # print 'train1 done! error1 = ' + str(error2)
    # accuracy2 = 1 - float(error2) / float(len(trainLabel))
    # print accuracy2

    accuracy1 = 0.8
    accuracy2 = 0.2

    clf3 = svm.SVR(kernel='linear')
    clf3.fit(trainF3, trainLabel)
    result3 = clf3.predict(testF3)
    clf4 = svm.SVR()
    clf4.fit(trainF1, trainLabel)
    result4 = clf4.predict(testF1)

    result = result3 * accuracy1 + result4 * accuracy2
    t = 0
    predictLabel = []
    for r in result:
        # if r / (accuracy2 + accuracy1) < 0.5:
        #     predictLabel.append(0)
        # else:
        #     predictLabel.append(1)
        if 1 <= r / (accuracy2 + accuracy1) < 2:
            predictLabel.append(1)
        if 2 <= r / (accuracy2 + accuracy1) < 3:
            predictLabel.append(2)
        if 3 <= r / (accuracy2 + accuracy1) < 4:
            predictLabel.append(3)
        if 4 <= r / (accuracy2 + accuracy1) < 5:
            predictLabel.append(4)
        if 5 <= r / (accuracy2 + accuracy1) < 6:
            predictLabel.append(5)
        if 6 <= r / (accuracy2 + accuracy1) < 7:
            predictLabel.append(6)
        if 7 <= r / (accuracy2 + accuracy1) < 8:
            predictLabel.append(7)
        if 8 <= r / (accuracy2 + accuracy1) < 9:
            predictLabel.append(8)
        if 9 <= r / (accuracy2 + accuracy1) < 10:
            predictLabel.append(9)
        if r / (accuracy2 + accuracy1) >= 10:
            predictLabel.append(10)
        t += 1
    error = 0
    o = 0
    for l in predictLabel:
        if l != testLabel[o]:
            error += 1
        o += 1

    print error
    print testLabel
    print predictLabel
    print '%.2f%%' % ((1-float(error)/float(len(testLabel)))*100)

    print 'time:' + str(time.clock() - start)




# testc = array([0] * 125)
# testp = array([1] * 125)
# testLabel = hstack((testc, testp))
# trainc = array([0] * 375)
# trainp = array([1] * 375)
# trainLabel = hstack((trainc, trainp))


# clf1 = svm.SVC(kernel = 'linear')
# # clf1 = pickle.load(open('GWtrain.pkl','rb'))
# clf1.fit(trainData3p, trainLabelp)
# # pickle.dump(clf1, open('GWtrain10.pkl', 'wb'))
# result1 = clf1.predict(trainData3p)
# # print result1
# # print trainLabelp
# error1 = 0
# i = 0
# for l in result1:
#     if l != trainLabelp[i]:
#          error1 = error1 + 1
#     i = i + 1
#
# print 'train3 done! error1 = '+ str(error1)
#
# clf2 = svm.SVC()
# # clf2 = pickle.load(open('GOtrain.pkl','rb'))
# clf2.fit(trainData1, trainLabel)
# # pickle.dump(clf1, open('GOtrain10.pkl', 'wb'))
# result2 = clf2.predict(trainData1)
# # print result2
# error2 = 0
# j = 0
# for l in result2:
#     if l != trainLabel[j]:
#          error2 = error2 + 1
#     j = j + 1
#
# print 'train1 done! error2 = ' + str(error2)
# accuracy1 = 1 - float(error1) / float(len(trainLabelp))
# accuracy2 = 1 - float(error2) / float(len(trainLabel))
# print accuracy1
# print accuracy2

# clf3 = svm.SVR(kernel='linear')
# # clf3 = pickle.load(open('GWtest.pkl','rb'))
# clf3.fit(trainData3p, trainLabelp)
# # pickle.dump(clf1, open('GWtest10.pkl','wb'))
# result3 = clf3.predict(testData3p)
# # print result3
# clf4 = svm.SVR()
# # clf4 = pickle.load(open('GOtest.pkl','rb'))
# clf4.fit(trainData1p, trainLabelp)
# # pickle.dump(clf1, open('GOtest10.pkl', 'wb'))
# result4 = clf4.predict(testData1p)
#
# # clf = pickle.load(open('svm_nose.pkl','rb'))
# accuracy1=0.85
# accuracy2=0.15
#
# result = result3 * accuracy1 + result4 * accuracy2
# t = 0
# predictLabel = []
# for r in result:
#     # if r / (accuracy2 + accuracy1) < 0.5:
#     #     predictLabel.append(0)
#     # else:
#     #     predictLabel.append(1)
#     # if 1 <= r / (accuracy2 + accuracy1) < 2:
#     #     predictLabel.append(1)
#     # if 2 <= r / (accuracy2 + accuracy1) < 3:
#     #     predictLabel.append(2)
#     # if 3 <= r / (accuracy2 + accuracy1) < 4:
#     #     predictLabel.append(3)
#     # if 4 <= r / (accuracy2 + accuracy1) < 5:
#     #     predictLabel.append(4)
#     if 5 <= r / (accuracy2 + accuracy1) < 6:
#         predictLabel.append(5)
#     if 6 <= r / (accuracy2 + accuracy1) < 7:
#         predictLabel.append(6)
#     if 7 <= r / (accuracy2 + accuracy1) < 8:
#         predictLabel.append(7)
#     if 8 <= r / (accuracy2 + accuracy1) < 9:
#         predictLabel.append(8)
#     if 9 <= r / (accuracy2 + accuracy1) < 10:
#         predictLabel.append(9)
#     if r / (accuracy2 + accuracy1) >= 10:
#         predictLabel.append(10)
#     t += 1
# error = 0
# o = 0
# for l in predictLabel:
#     if l != testLabelp[o]:
#         error += 1
#     o += 1
#
# # for i in range(1, 51):
# #     print predictLabel[(i-1)*5:i*5]
# print error
# print testLabelp
# print predictLabel
# print '%.2f%%' % ((1-float(error)/float(len(testLabelp)))*100)
#
