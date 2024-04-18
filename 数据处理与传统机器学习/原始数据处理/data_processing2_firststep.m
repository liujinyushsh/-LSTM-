clear;clc;
%% 改变path可查看不同组实验结果
path = 'C:\Users\24317\Desktop\me\bone_milling\dataset\exps_original\exp3';
[dep_be_fil, dep_af_fil, t, acc, sou_pre] = draw_pictures(path);

% 切分出可用数据段
dt = 0.00005;
t1_start = 12; t1_end =30;
%exp1:[7,29.5];exp2:[8,24];exp3:[12,30];exp4:[6,23];exp5:[6,20];此处以20khz为基准
t1 = t1_start:dt:t1_end;
acc1 = acc(t1_start/dt:t1_end/dt);
sou_pre1 = sou_pre(t1_start/dt:t1_end/dt);
figure;
plot(t1, sou_pre1);
plot(t1,acc1);

% 首先对深度信息进行移动平均滤波
window_width = 1000;  % 选取滤波窗口长度为dep_be的1%数量级
dep_be_fil = movmean(dep_be_fil, window_width);
dep_af_fil = movmean(dep_af_fil, window_width);
figure;
plot(dep_be_fil);
hold on;
plot(dep_af_fil);

% 然后对dep_be_fil和dep_af_fil进行对准
num_end = min(length(dep_be_fil), length(dep_af_fil));
dep_be_fil = dep_be_fil(1:num_end);
dep_af_fil = dep_af_fil(1:num_end);
avg_dep_be = mean(dep_be_fil(length(dep_be_fil)-20000, end));   
avg_dep_af = mean(dep_af_fil(length(dep_af_fil)-20000, end));
if avg_dep_be < avg_dep_af
    dep_af_fil = dep_af_fil - abs(avg_dep_be - avg_dep_af);
else
    dep_af_fil = dep_af_fil + abs(avg_dep_be - avg_dep_be);
end
figure;
plot(dep_be_fil);
hold on;
plot(dep_af_fil);

% 切分出深度信息
idx1_start = 34101; idx1_end =86886;
%exp1:[1,83450];exp2:[33810,108000];exp3:[34101,86886];exp4:[31000,93000];exp5:[32000,78000];
dep_be_fil1 = dep_be_fil(idx1_start:idx1_end);
dep_af_fil1 = dep_af_fil(idx1_start:idx1_end);

figure;
plot(dep_be_fil1);
hold on;
plot(dep_af_fil1);

% 计算出被铣削深度
depth1 = dep_be_fil1 - dep_af_fil1-0.8;

% 去除小于0的深度
for i=1:length(depth1)
    if depth1(i) < 0
        depth1(i) = 0;
        break
    end
end

figure;
plot(depth1);

%% 播放铣削过程声音，手动标注铣削起始，结束点
% load 实验二\Sound_Pressure_raw.txt
% Fs = 20000;
% sound(Sound_Pressure_raw, Fs);

%% 加载皮质骨深度占比信息
load("dep_Pro\dep_pro_exp5.csv");
% 由于扫描图像是从左到右，铣削过程是从右往左，故将dep_pro反转
dep_pro_exp = fliplr(dep_pro_exp5);
figure;
plot(dep_pro_exp);

%将有用的部分截取出来
dep_pro_exp_final = dep_pro_exp(160:430);
%exp1:[6,185];exp2:[105,255];exp3:[38,82];exp4:[13,316];exp5:[160,430];

%% 将acc, sou_pre, depth, dep_pro_exp显示在一起
figure;
subplot(4,1,1);
plot(t1, acc1);
subplot(4,1,2);
plot(t1, sou_pre1);
subplot(4,1,3);
plot(depth1);
subplot(4,1,4);
plot(dep_pro_exp_final);

% 保存所需变量
writematrix(depth1, 'C:\Users\24317\Desktop\me\bone_milling\dataset\exps_solved\data_temp_new\depth3.csv');
writematrix(dep_pro_exp_final, 'data_temp_new_1000\dep_pro1.csv');
writematrix(acc1,'C:\Users\24317\Desktop\me\bone_milling\dataset\exps_solved\data_temp_new\acc3.csv');
writematrix(sou_pre1,'data_temp_new_1000\sou_pre1.csv');
