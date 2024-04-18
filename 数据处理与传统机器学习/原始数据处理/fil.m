clc;
clear all;
load('C:\Users\24317\Desktop\dep_be_fil.mat')
load('C:\Users\24317\Desktop\dep_af_fil.mat')
% 首先对深度信息进行移动平均滤波
window_width = 5000;  % 选取滤波窗口长度为dep_be的1%数量级
dep_be_fil_5000 = movmean(dep_be_fil, window_width);
dep_af_fil_5000 = movmean(dep_af_fil, window_width);
brownColor = [0.647, 0.165, 0.165];
grayColor = [0.412, 0.412, 0.412];

x = [1:length(dep_be_fil_5000)];
x = x ./ 300;


figure;
plot(x, dep_be_fil,'b-');
hold on;
plot(x, dep_af_fil,'r-');
hold on;
plot(x, dep_be_fil_5000,'g-',LineWidth=1.3);
hold on;
plot(x, dep_af_fil_5000,'Color',brownColor,LineWidth=1.3);

xlim([0, 550]);


xlabel('铣削长度/mm');
ylabel('深度/mm');
set(gca, 'FontName', 'Times New Roman'); % 设置坐标轴的字体名称
legend('铣削前', '铣削后', '铣削前(滤波)', '铣削后(滤波)');