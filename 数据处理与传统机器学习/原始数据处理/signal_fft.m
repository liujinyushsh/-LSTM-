clear;clc;

% 读取数据
M = readmatrix('dataset.xlsx','Range','B2:EWW1562');
load("Features.mat");
% 对每一行数据的加速度特征与声压特征进行傅里叶变换
n = size(Features,1); % 样本个数
% Fre_features = zeros(n, 20);
for i=1:n
    [f, P1_acc] = my_fft(Features, i);
    Fre_features(i, 1:501) = P1_acc;
    % Fre_features(i, 1002:2002) = P1_sound;
end

% 保存fft后的结果
writematrix(Fre_features, 'fft_features_all.xlsx');
% 手动附加上深度和皮质骨占比标签在最后两列

%% test:画单个样本fft
i = 1; %松质骨6595，皮质骨3650
[f, P1_acc, P1_sound] = my_fft(M, i);

% 原始信号
figure('color','w', 'Position',[500, 0, 1000, 500]);
subplot(2,2,1);
plot([0:0.00005:1999*0.00005], M(i, 1:2000));
% ylim([-7.5, 7.5]);
xlabel('Time/s');
ylabel('加速度/(m{\cdot}s{^{-2}})', 'FontName','TimesNewRoman');
subplot(2,2,3);
plot([0:0.00005:1999*0.00005], M(i, 2001:4000),'color', '#D95319');
% ylim([-0.4, 0.4]);
xlabel('时间/s');
ylabel('声压/Pa', 'FontName','TimesNewRoman');

% FFT信号
subplot(2,2,2);
plot(f, P1_acc, 'LineWidth',1.2);
% ylim([0, 2]);
xlabel('频率/Hz');
ylabel('幅值');
subplot(2,2,4);
plot(f, P1_sound, 'LineWidth',1.2, 'color', '#D95319');
% ylim([0, 0.2]);
xlabel('频率/Hz');
ylabel('幅值');
