clear all;
M1_1 = readmatrix("C:\Users\24317\Desktop\me\bone_milling\dataset\exps_solved\data_train_new\dep_pro_instance1.csv");
M2_1=readmatrix("C:\Users\24317\Desktop\me\bone_milling\dataset\exps_solved\data_train_new\acc1_slice.csv");
M4_1=readmatrix("C:\Users\24317\Desktop\me\bone_milling\dataset\exps_solved\data_train_new\depth_instance1.csv");

M1_2 = readmatrix("C:\Users\24317\Desktop\me\bone_milling\dataset\exps_solved\data_train_new\dep_pro_instance2.csv");
M2_2=readmatrix("C:\Users\24317\Desktop\me\bone_milling\dataset\exps_solved\data_train_new\acc2_slice.csv");
M4_2=readmatrix("C:\Users\24317\Desktop\me\bone_milling\dataset\exps_solved\data_train_new\depth_instance2.csv");

M1_3 = readmatrix("C:\Users\24317\Desktop\me\bone_milling\dataset\exps_solved\data_train_new\dep_pro_instance3.csv");
M2_3=readmatrix("C:\Users\24317\Desktop\me\bone_milling\dataset\exps_solved\data_train_new\acc3_slice.csv");
M4_3=readmatrix("C:\Users\24317\Desktop\me\bone_milling\dataset\exps_solved\data_train_new\depth_instance3.csv");

M1_4 = readmatrix("C:\Users\24317\Desktop\me\bone_milling\dataset\exps_solved\data_train_new\dep_pro_instance4.csv");
M2_4=readmatrix("C:\Users\24317\Desktop\me\bone_milling\dataset\exps_solved\data_train_new\acc4_slice.csv");
M4_4=readmatrix("C:\Users\24317\Desktop\me\bone_milling\dataset\exps_solved\data_train_new\depth_instance4.csv");

M1_5 = readmatrix("C:\Users\24317\Desktop\me\bone_milling\dataset\exps_solved\data_train_new\dep_pro_instance5.csv");
M2_5=readmatrix("C:\Users\24317\Desktop\me\bone_milling\dataset\exps_solved\data_train_new\acc5_slice.csv");
M4_5=readmatrix("C:\Users\24317\Desktop\me\bone_milling\dataset\exps_solved\data_train_new\depth_instance5.csv");

Features1 = M2_1(1:end, 1:end);
depth1 = M4_1(1, 1:end);
depth_proportion1 = M1_1(1:end, 1:end);

Features2 = M2_2(1:end, 1:end);
depth2 = M4_2(1, 1:end);
depth_proportion2 = M1_2(1:end, 1:end);

Features3 = M2_3(1:end, 1:end);
depth3 = M4_3(1, 1:end);
depth_proportion3 = M1_3(1:end, 1:end);

Features4 = M2_4(1:end, 1:end);
depth4 = M4_4(1, 1:end);
depth_proportion4 = M1_4(1:end, 1:end);

Features5 = M2_5(1:end, 1:end);
depth5 = M4_5(1, 1:end);
depth_proportion5 = M1_5(1:end, 1:end);

Features=[Features1;Features2;Features3];
depth=[depth1,depth2,depth3];
depth=depth(1:1982);
depth_proportion=[depth_proportion1,depth_proportion2,depth_proportion3,depth_proportion4,depth_proportion5];
% Features=Features1;
% depth=depth1;
