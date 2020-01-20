import pickle
import os
from sklearn import svm
from numpy import *
import matplotlib.pyplot as plt

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


# testData = getData('E:\\water\\Now\\testICPR576.csv')
trainData = getData('E:\\water\\Now\\trainICPR576.csv')

Hcmean = trainData[:125,96:192]
Hpmean = trainData[125:,96:192]

Scmean = trainData[:125,288:384]
Spmean = trainData[125:,288:384]

Vcmean = trainData[:125,480:576]
Vpmean = trainData[125:,480:576]

x = range(1,97)

m1 = mean(Vcmean,axis=0)
plt.scatter(x, m1,c='r',marker='o')
m2 = mean(Vpmean,axis=0)
plt.scatter(x,m2,c='b',marker='o')
plt.ylim(0,0.008)
# plt.plot(x,m1)
# plt.plot(x,m2)

# for i in Hcmean:
#     plt.scatter(x, i,c='r',marker='o')
# plt.scatter(x,Hcmean)

# for j in Hpmean:
#     plt.scatter(x,j,c='b',marker='o')
plt.legend()
plt.show()