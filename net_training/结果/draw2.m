clear all;
clc;
% 创建一个图形窗口
readmatrix("C:\Users\24317\Desktop\before.csv")
readmatrix("C:\Users\24317\Desktop\dep_af.csv")
after=after+0.8;
figure('Color','white');
set(gca,'Fontname','Times New Roman')
dt=0.00005;
% 设置一个足够大的 x 轴范围
x_axis_limit = [0, 15]; % 你可以根据需要设置更大的范围

% 使用 axis 函数来设置初始 x 轴范围
axis([x_axis_limit, -5, 5]);

% 创建一个 animatedline 对象
lineObj = animatedline;
lineObj.MaximumNumPoints = 5000000;
lineObj.Color='b';
lineObj2 = animatedline;
lineObj2.Color='r';
x=1;
j=1;
blueColor = [0, 0, 1];
% 循环逐步添加数据点并更新图形
for i = 1:dt:(length(before)*dt)
    if i==225780
        break;
    end
    addpoints(lineObj, (x:dt:x+0.2), before(j:j+(1/dt)*0.2)); % 添加新的数据点
    addpoints(lineObj2, (x:dt:x+0.2), after(j:j+(1/dt)*0.2)); % 添加新的数据点
    title('Laser Displacement Sensor');
    xlabel('Time/s');
    ylabel('Depth/mm');
    drawnow; % 更新图形
    pause(0.2);
 % 暂停一小段时间以观察图形更新
    j=j+(1/dt)*0.2;
    x=x+0.2;
end
