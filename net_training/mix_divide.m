function [XTrain,YTrain, XValidation,YValidation, XTest,YTest, raw_XTrain,raw_YTrain, raw_XValidation,...
    raw_YValidation, raw_XTest,raw_YTest] = mix_divide(Features,depth,raw_features,raw_depth, features_size)
%打乱与切分数据集

% 将数据集打乱
randIndex = randperm(size(Features, 1));
Features = Features(randIndex, :);
depth = depth(randIndex, :);

randIndex = randperm(size(raw_features, 1));
raw_features = raw_features(randIndex, :);
raw_depth = raw_depth(randIndex, :);

% 将数据处理成特征在列方向上，每一列是一个样本
num_instance = size(depth,1);  % 样本数量
num_train = round(num_instance * 0.7); 
num_validation = round(num_instance * 0.2);
num_test = num_instance - num_train - num_validation;

XTrain = Features(1:num_train, features_size)'; YTrain = depth(1:num_train, 1)';
XValidation = Features(num_train+1:num_train+num_validation, features_size)'; YValidation = depth(num_train+1:num_train+num_validation, 1)';
XTest = Features(num_train+num_validation+1:end, features_size)'; YTest = depth(num_train+num_validation+1:end, 1)';

raw_num_instance = size(raw_depth,1);  % 样本数量
raw_num_train = round(raw_num_instance * 0.7); 
raw_num_validation = round(raw_num_instance * 0.2);
raw_num_test = raw_num_instance - raw_num_train - raw_num_validation;

raw_XTrain = raw_features(1:raw_num_train, features_size)';
raw_YTrain = raw_depth(1:raw_num_train, 1)';
raw_XValidation = raw_features(raw_num_train+1:raw_num_train+raw_num_validation, features_size)';
raw_YValidation = raw_depth(raw_num_train+1:raw_num_train+raw_num_validation, 1)';
raw_XTest = raw_features(raw_num_train+raw_num_validation+1:end, features_size)';
raw_YTest = raw_depth(raw_num_train+raw_num_validation+1:end, 1)';

end