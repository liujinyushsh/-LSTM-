%%% 预测皮质骨占比网络
clear;clc;
%% 加载数据
load("C:\Users\24317\Desktop\me\bone_milling\net_training\final_data_for_train\Features.mat");
load("C:\Users\24317\Desktop\me\bone_milling\net_training\final_data_for_train\depth.mat");
load("C:\Users\24317\Desktop\zhan\Bone-Milling-22.12_simple\data_matlab_format\data_matlab_format\网络\net_depth1.mat");

%% 数据增强（离线）
% 先保存原始数据集，用于最后的预测


depth=depth(1:1600);
Features=Features(1:1600,:);

features_length=1000;
raw_features = Features;
raw_depth = depth';
depth=depth';

for i=1:5  % 添加随机噪声，将数据集扩充5倍
    data = [Features, depth];  % 将特征与标签拼接
    noise_factor = 0.03;  % 噪声系数
%     noise = rand(size(data,1),4000);  % 随机生成噪声
    noise =  -1 + rand(size(data,1),features_length) * 2 / 1;  % 随机生成噪声
    aug_feature = data(:,1:features_length) + noise_factor*noise;  % 将噪声叠加到原始数据上
    aug_data = [aug_feature, data(:, end)];  
    data = [data;aug_data]; % 原始数据与增强数据进行拼接，标签不改变
    % 最后再次拆分出特征与标签
    Features = data(:, 1:features_length);  
    depth = data(:, end);
end

%% 划分训练集与测试集（acc)
features_size = 1:features_length;
 [XTrain,YTrain, XValidation,YValidation, XTest,YTest, raw_XTrain,raw_YTrain, raw_XValidation,...
    raw_YValidation, raw_XTest,raw_YTest] = mix_divide(Features,depth,raw_features,raw_depth, features_size);

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
test=predict(net1,XTest);
figure;
plot(test(1:500));
hold on;
plot(YTest(1:500));
legend("predict","real");
title("LSTM","FontName","Times New Rome");
xlabel("sequence","FontName","Times New Rome");
ylabel("angle","FontName","Times New Rome");
set(gca,'FontName','Times New Rome');

% % test
% unifrnd(-1,1);
% randnum = -1 + rand([100,100]) * 2 / 1;
% hist(randnum);



%BP神经网络
input_train=Features';
output_train=depth';

%归一化，inputn是归一化结果，inputs是归一化方法
[inputn,inputs]=mapminmax(input_train);
[outputn,outputs]=mapminmax(output_train);

%网络训练
net=newff(inputn,outputn,100,{'tansig','purelin'},'trainlm');
net.trainParam.epochs=1000;
net.trainParam.lr=0.0001;
net.trainParam.goal=0.00001;
net=train(net,inputn,outputn);

%测试
inputn_test=mapminmax('apply',inputn,inputs);
an=sim(net,inputn);
test_simu=mapminmax('reverse',an,outputs);

plot(test_simu(1:500));
hold on;
plot(depth(1:500));
legend("predict","real");
title("BP","FontName","Times New Rome");
xlabel("sequence","FontName","Times New Rome");
ylabel("angle","FontName","Times New Rome");
set(gca,'FontName','Times New Rome');


load("C:\Users\24317\Desktop\me\bone_milling\dataset\exps_original\exp3\Acceleration.txt")
plot(Acceleration(60000:140000))
axis([1,80000,-150,150])

num = [16];
den = [1 4 16];
sys = tf(num,den);


nyquist(sys)

