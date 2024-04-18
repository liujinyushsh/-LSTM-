function [dep_be, dep_af, t, acc, sou_pre] = draw_pictures(path)
    % 铣削前深度
    dep_be = readmatrix([path,'\before.csv'],'Range','C:C');

    % 加速度信号与声压信号
    acc = load([path,'\Acceleration.txt']);
    sou_pre = load([path,'\Sound_Pressure.txt']);
    dt = 0.00005;
    t = 0:dt:dt*(length(acc)-1);
    
    figure;
    subplot(2,1,1);
    plot(t,acc);
    xlabel('time/s');
    ylabel('acceleration/{m*s^-2}');
    
    subplot(2,1,2);
    plot(t, sou_pre);
    xlabel('time/s');
    ylabel('sound_pressure/Pa');

    % 铣削后深度
    dep_af = readmatrix([path,'\after.csv'],'Range','C:C');

    % 铣削前后深度对比
    figure;
    plot(dep_be);
    hold on;
    plot(dep_af);
    legend('before', 'after');
end