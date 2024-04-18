function [data_slice] = data_slice(raw_data)
    % 数据切片
    t = 1; %起始切片时间
    %更改切片时间范围可以更改处理后的特征长度
    t_range = 2000-1; %时间范围(每2000个数，即0.1s划分为一个样本)
    i = 1; %当前存储行数
    while t < (length(raw_data) - t_range)
        data_slice(i,:) = raw_data(t:t+t_range);
        t = t + t_range+1; %更新下一次起始切片时间
        i = i + 1; %更新下一次存储行数
    end      
end