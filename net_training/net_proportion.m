%%% 预测皮质骨占比网络
clear;clc;
%% 加载数据
load('Features.mat');
load('depth_proportion.mat');
%% 加载网络
load('网络\net_depth3.mat');
%% 数据增强（离线）
% 先保存原始数据集，用于最后的预测
raw_features = Features;
raw_depth_proportion = depth_proportion';
depth_proportion=depth_proportion';
for i=1:6  % 添加随机噪声，将数据集扩充5倍
    data = [Features, depth_proportion];  % 将特征与标签拼接
    noise_factor = 0.03;  % 噪声系数
%     noise = rand(size(data,1),4000);  % 随机生成噪声
    noise =  -1 + rand(size(data,1),1000) * 2 / 1;  % 随机生成噪声
    aug_feature = data(:,1:1000) + noise_factor*noise;  % 将噪声叠加到原始数据上
    aug_data = [aug_feature, data(:, end)];  
    data = [data; aug_data]; % 原始数据与增强数据进行拼接，标签不改变
    % 最后再次拆分出特征与标签
    Features = data(:, 1:1000);  
    depth_proportion = data(:, end);
end

%% 划分训练集与测试集（acc)
features_size = 1:1000;
[XTrain,YTrain, XValidation,YValidation, XTest,YTest, raw_XTrain,raw_YTrain, raw_XValidation,...
    raw_YValidation, raw_XTest,raw_YTest] = mix_divide(Features,depth_proportion,raw_features,raw_depth_proportion, features_size);

%% 训练
miniBatchSize = 64;
options = trainingOptions('adam', ...
'ExecutionEnvironment','gpu', ...
'MaxEpochs',120, ...
'MiniBatchSize',miniBatchSize, ...
'ValidationData',{XValidation,YValidation}, ...
'GradientThreshold',2, ...
'Shuffle','every-epoch', ...
'ValidationFrequency',10,...
'Verbose',false, ...
'Plots','training-progress');
net1 = trainNetwork(XTrain,YTrain,layers_1,options);

%% 预测
[YPred_train, YPred_val, YPred_test] = my_predict(net1, raw_XTrain,raw_YTrain,raw_XValidation,...
    raw_YValidation,raw_XTest,raw_YTest);