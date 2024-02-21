close all
clear all
clc
classnumber=2;
categories={'样本熵','模糊熵','近似熵','盒维数'};

data=xlsread('E.xlsx','B2:F1001');
wine=data(:,1:4);
wine_labels=data(:,5);

%% 清空环境变量
format compact;

% 将第一类的1-30,第二类的60-95,第三类的131-153做为训练集
train_wine = [wine(1:475,:);wine(501:975,:)];
% 相应的训练集的标签也要分离出来
train_wine_labels = [wine_labels(1:475);wine_labels(501:975)];
% 将第一类的31-59,第二类的96-130,第三类的154-178做为测试集
test_wine = [wine(476:500,:);wine(976:1000,:)];
% 相应的测试集的标签也要分离出来
test_wine_labels = [wine_labels(476:500);wine_labels(976:1000)];

%% 数据预处理
% 数据预处理,将训练集和测试集归一化到[0,1]区间

[mtrain,ntrain] = size(train_wine);
[mtest,ntest] = size(test_wine);

dataset = [train_wine;test_wine];
% mapminmax为MATLAB自带的归一化函数
[dataset_scale,ps] = mapminmax(dataset',0,1);
dataset_scale = dataset_scale';

train_wine = dataset_scale(1:mtrain,:);
test_wine = dataset_scale( (mtrain+1):(mtrain+mtest),: );
%% SVM网络训练
model = svmtrain(train_wine_labels, train_wine, '-c 2 -g 1');

%% SVM网络预测
[predict_label, accuracy] = svmpredict(test_wine_labels, test_wine, model);

%% 结果分析
% 测试集的实际分类和预测分类图
% 通过图可以看出没有测试样本是被错分的
figure
plot(test_wine_labels,'o');hold on;
plot(predict_label,'r*');
xlabel('Number of samples','FontSize',12);
ylabel('Category label','FontSize',12);
legend('Real label','Predicted label');
