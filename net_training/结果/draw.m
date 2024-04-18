clear all;
clc;
% 创建一个图形窗口
load("C:\Users\24317\Desktop\re\Acceleration_raw.txt")
figure('Color','white');
set(gca,'Fontname','Times New Roman')
dt=0.00005;
% 设置一个足够大的 x 轴范围
x_axis_limit = [0, 100]; % 你可以根据需要设置更大的范围

% 使用 axis 函数来设置初始 x 轴范围
axis([x_axis_limit, -150, 150]);

% 创建一个 animatedline 对象
lineObj = animatedline;
lineObj.Color='#0072BD';
lineObj.MaximumNumPoints = 5000000;
x=1;
j=1;
% 循环逐步添加数据点并更新图形
for i = 1:dt:(length(Acceleration_raw)*dt)
    addpoints(lineObj, (x:dt:x+0.2), Acceleration_raw(j:j+(1/dt)*0.2)); % 添加新的数据点
    title('');
    xlabel('Time/s');
    ylabel('Acceleration/mm/s^2');
    drawnow; % 更新图形
    pause(0.02);
 % 暂停一小段时间以观察图形更新
    j=j+(1/dt)*0.2;
    x=x+0.2;
end
