import xgboost as xgb
import pandas as pd
import numpy as np
from sklearn.metrics import accuracy_score

trainData = pd.read_csv('../data/trainData.csv', header=None)
trainLabel = pd.read_csv('../data/trainLabel.csv', header=None, index_col=False)
testData = pd.read_csv('../data/testData.csv', header=None)
testLabel = pd.read_csv('../data/testLabel.csv', header=None, index_col=False)

trainLabel_array = np.array(trainLabel)
# label的值都减1,xgboost多分类label以0开始
trainLabel_array = trainLabel_array - 1
train_Label = pd.DataFrame(trainLabel_array.T[:-1], dtype=int)
print(train_Label.shape)
print(trainData.shape)

testLabel_array = np.array(testLabel)
# label的值都减1,xgboost多分类label以0开始
testLabel_array = testLabel_array - 1
test_Label = pd.DataFrame(testLabel_array.T[:-1], dtype=int)
print(test_Label.shape)
print(testData.shape)

#print(trainData.iloc[:,-148:].shape)
dataset1 = xgb.DMatrix(trainData.iloc[:,-147:], label=train_Label)
# dataset2 = xgb.DMatrix(testData,label=test_Label);
testX = xgb.DMatrix(testData.iloc[:,-147:])

params = {'booster': 'gbtree',
          'objective': 'multi:softmax',
          'eval_metric': 'mlogloss',
          'gamma': 0.1,
          'min_child_weight': 1.1,
          'max_depth': 5,
          'lambda': 10,
          'subsample': 0.7,
          'colsample_bytree': 0.7,
          'colsample_bylevel': 0.7,
          'eta': 0.01,
          'tree_method': 'exact',
          'seed': 0,
          'nthread': 4,
          'num_class': 10
          }

watchlist = [(dataset1, 'train')]
model = xgb.train(params, dataset1, num_boost_round=1500, evals=watchlist, verbose_eval=False)

result = model.predict(testX)

print(accuracy_score(test_Label, result, normalize=True))

# save feature score
feature_score = model.get_fscore()
feature_score = sorted(feature_score.items(), key=lambda x: x[1], reverse=True)
fs = []
for (key, value) in feature_score:
    fs.append("{0},{1}\n".format(key, value))

with open('xgb_feature_score.csv', 'w') as f:
    f.writelines("feature,score\n")
    f.writelines(fs)
