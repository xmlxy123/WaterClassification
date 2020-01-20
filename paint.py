import pickle
import os
from sklearn import svm
import numpy as np
import matplotlib.pyplot as plt

mettes = pickle.load(open('E:\\water\\MettesAccuracy10.pkl', 'rb'))
our = pickle.load(open('E:\\water\\OurAccuracy10.pkl', 'rb'))
alex = pickle.load(open('E:\\water\\AlexAccuracy10.pkl', 'rb'))

x=[0,100,200,300,400,500,600,700,800,900,1000,1100,1200,1300,1400,1500,1600,1700,1800,1900,2000,2100,2200,2300,2400,2500]
mettes.insert(0,0)
mettes.insert(1,0.2)
a = mettes.pop()
# mettes[1]=0.2
our.insert(0,0)
alex.insert(0,0)
print mettes
print our
print alex
# print alex
# for f in mettes:
#     m.append(f[0])
# print m
# for r in trainFeature:
    # trainData.append(r[0])

# plt.xlim(0, 2500)

plt.plot(x,mettes,label='Mettes et al. [1]')
plt.plot(x,our,label='Proposed method')
plt.plot(x,alex,label='Qi et al. [12]')
plt.ylim(0,1)

# cc= np.linspace(0,2,100)
#
# plt.plot(cc,cc,label='linear')
#
# plt.plot(cc,cc**2,label='2')
#
# plt.plot(cc,cc**3,label='3')
#
# plt.xlabel('x label')
#
# plt.ylabel('y label')

# plt.title("11111111")

plt.legend()

plt.show()