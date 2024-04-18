function [f, P1_acc] = my_fft(M, i) %输入：原始数据矩阵，对第i行进行fft
    signal_acc = M(i,1:1000); % 加速度信号

    Fs = 20000;            % 采样频率20kHz
    T = 1/Fs;             % 采样周期
    L = 1000;             % 信号长度

    Y_acc = fft(signal_acc); % fft变换
    P2_acc = abs(Y_acc/L);
    P1_acc = P2_acc(1:L/2+1);
    P1_acc(2:end-1) = 2*P1_acc(2:end-1);
    f = Fs*(0:(L/2))/L;


%     figure('color','w', 'Position', [500, 200, 800, 500]);
%     sgtitle('fft');
%     subplot(2,1,1);
%     plot(f, P1_acc);
%     title('加速度');
%     xlabel('f(Hz)');
%     ylabel('|P1(f)|');
%     
%     subplot(2,1,2);
%     plot(f, P1_sound);
%     title('声压');
%     xlabel('f(Hz)');
%     ylabel('|P1(f)|');
end