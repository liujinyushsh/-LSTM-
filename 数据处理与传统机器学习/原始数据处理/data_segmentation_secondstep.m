clear;clc;
acc1=load('C:\Users\24317\Desktop\me\bone_milling\dataset\exps_solved\data_temp_new\acc3.csv');
sou_pre1=load('C:\Users\24317\Desktop\me\bone_milling\dataset\exps_solved\data_temp_new\sou_pre3.csv');
depth1=load('C:\Users\24317\Desktop\me\bone_milling\dataset\exps_solved\data_temp_new\depth3.csv');
dep_pro1=load('data_temp_new\dep_pro1.csv');

% plot(acc1);pause(2);
% plot(acc2);pause(2);
% plot(sou_pre1);pause(2);
% plot(sou_pre2);pause(2);
% plot(depth1);pause(2);
% plot(depth2);pause(2);
% plot(dep_pro1);pause(2);
% plot(dep_pro2);pause(2);

%% 数据切片
acc1_slice = data_slice(acc1);
sou_pre1_slice = data_slice(sou_pre1);

%% 将深度、皮质骨占比平均为和样本数一样多
num1 = size(acc1_slice,1);
% 深度
len_per_instance1 = ceil(length(depth1) / num1);
% 将原始depth和dep_pro插值，保证能分为整数个窗口
new_x = 1:length(depth1)/(len_per_instance1*num1):length(depth1);
depth1 = interp1(1:length(depth1), depth1, new_x);
depth1 = [depth1,depth1(end)];
% figure;
% plot(depth1);

t = 1;  %index
i = 1;  %行数
while t <= length(depth1) - len_per_instance1+1
    depth_instance1(i) = mean(depth1(t:t+len_per_instance1-1));
    t = t + len_per_instance1;
    i = i + 1;
end
figure;
plot(depth_instance1);

% 皮质骨占比
% 先插值为样本数的两倍
new_x = 1:length(dep_pro1)/(num1*2):length(dep_pro1);
dep_pro1 = interp1(1:length(dep_pro1), dep_pro1, new_x);
dep_pro1 = [dep_pro1,dep_pro1(end)];
% figure;
% plot(dep_pro1);
len_per_instance1 = 2;

t = 1;  %index
i = 1;  %行数
while t <= length(dep_pro1) - len_per_instance1+1
    dep_pro_instance1(i) = mean(dep_pro1(t:t+len_per_instance1-1));
    t = t + len_per_instance1;
    i = i + 1;
end
figure;
plot(dep_pro_instance1);

%% 保存变量，制作可直接导入PyTorch的数据集
writematrix(acc1_slice, 'C:\Users\24317\Desktop\me\bone_milling\dataset\exps_solved\data_train_new\acc3_slice.csv');
writematrix(sou_pre1_slice, 'C:\Users\24317\Desktop\me\bone_milling\dataset\exps_solved\data_train_new\sou_pre3_slice.csv');
writematrix(depth_instance1, 'C:\Users\24317\Desktop\me\bone_milling\dataset\exps_solved\data_train_new\depth_instance3.csv');
writematrix(dep_pro_instance1, 'C:\Users\24317\Desktop\me\bone_milling\dataset\exps_solved\data_train_new\dep_pro_instance1.csv');






