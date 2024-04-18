function [YPred_train, YPred_val, YPred_test] = my_predict(net, raw_XTrain,raw_YTrain,raw_XValidation,...
    raw_YValidation,raw_XTest,raw_YTest)
%预测函数，使用acc特征与sou_pre特征共同预测，
% %两个网络输出的平均值作为预测
% YPred_train = (predict(net1, raw_XTrain1)+predict(net2, raw_XTrain2)) / 2;
% YPred_val = (predict(net1, raw_XValidation1)+predict(net2, raw_XValidation2)) / 2;
% YPred_test = (predict(net1, raw_XTest1)+predict(net2, raw_XTest2)) / 2;

YPred_train = predict(net, raw_XTrain);
YPred_val = predict(net, raw_XValidation);
YPred_test = predict(net, raw_XTest);

figure;
plot(YPred_train, raw_YTrain, 'k.');
hold on;
plot(YPred_val, raw_YValidation,   '.');
title('训练集与验证集');
axis([0,4,0,4]);
figure;
plot(YPred_test, raw_YTest,  '.');
title('测试集');
axis([0,4,0,4]);
end