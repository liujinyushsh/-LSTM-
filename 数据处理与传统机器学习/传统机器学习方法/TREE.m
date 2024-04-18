clc;
clear all;
acc1=readmatrix("C:\Users\24317\Desktop\zhan\Bone-Milling-22.12_simple\data_train_new_2000\acc1_slice.csv");
depth1=readmatrix("C:\Users\24317\Desktop\zhan\Bone-Milling-22.12_simple\data_train_new_2000\depth_instance1.csv");
acc2=readmatrix("C:\Users\24317\Desktop\zhan\Bone-Milling-22.12_simple\data_train_new_2000\acc2_slice.csv");
depth2=readmatrix("C:\Users\24317\Desktop\zhan\Bone-Milling-22.12_simple\data_train_new_2000\depth_instance2.csv");
acc3=readmatrix("C:\Users\24317\Desktop\zhan\Bone-Milling-22.12_simple\data_train_new_2000\acc3_slice.csv");
depth3=readmatrix("C:\Users\24317\Desktop\zhan\Bone-Milling-22.12_simple\data_train_new_2000\depth_instance3.csv");
acc4=readmatrix("C:\Users\24317\Desktop\zhan\Bone-Milling-22.12_simple\data_train_new_2000\acc4_slice.csv");
depth4=readmatrix("C:\Users\24317\Desktop\zhan\Bone-Milling-22.12_simple\data_train_new_2000\depth_instance4.csv");
acc5=readmatrix("C:\Users\24317\Desktop\zhan\Bone-Milling-22.12_simple\data_train_new_2000\acc5_slice.csv");
depth5=readmatrix("C:\Users\24317\Desktop\zhan\Bone-Milling-22.12_simple\data_train_new_2000\depth_instance5.csv");

acc=[acc1;acc2;acc3;acc4;acc5];
depth=[depth1,depth2,depth3,depth4,depth5];

maxk=10;%fft前maxk个分量

fft_feature = zeros(1,maxk,size(acc,1));
for i=1:size(acc,1)
    [f,P_acc1] = my_fft(acc,i);
    [sorted_P,index]=sort(P_acc1,"descend");
    max10_P = P_acc1(index(1:maxk));
    max10_f = f(index(1:maxk));
    fft_feature(:,:,i)=[max10_P];
end
tree=fitrtree(reshape(fft_feature,[],maxk), depth);
pre2=zeros(size(acc,1),1);
for i=1:size(acc,1)
    pre2(i,:)=predict(tree,reshape(fft_feature(:,:,i),[],maxk));
end
figure;
scatter(depth,pre2);
