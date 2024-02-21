close all
clear all
clc
classnumber=2;
categories={'������','ģ����','������','��ά��'};

data=xlsread('E.xlsx','B2:F1001');
wine=data(:,1:4);
wine_labels=data(:,5);

%% ��ջ�������
format compact;

% ����һ���1-30,�ڶ����60-95,�������131-153��Ϊѵ����
train_wine = [wine(1:475,:);wine(501:975,:)];
% ��Ӧ��ѵ�����ı�ǩҲҪ�������
train_wine_labels = [wine_labels(1:475);wine_labels(501:975)];
% ����һ���31-59,�ڶ����96-130,�������154-178��Ϊ���Լ�
test_wine = [wine(476:500,:);wine(976:1000,:)];
% ��Ӧ�Ĳ��Լ��ı�ǩҲҪ�������
test_wine_labels = [wine_labels(476:500);wine_labels(976:1000)];

%% ����Ԥ����
% ����Ԥ����,��ѵ�����Ͳ��Լ���һ����[0,1]����

[mtrain,ntrain] = size(train_wine);
[mtest,ntest] = size(test_wine);

dataset = [train_wine;test_wine];
% mapminmaxΪMATLAB�Դ��Ĺ�һ������
[dataset_scale,ps] = mapminmax(dataset',0,1);
dataset_scale = dataset_scale';

train_wine = dataset_scale(1:mtrain,:);
test_wine = dataset_scale( (mtrain+1):(mtrain+mtest),: );
%% SVM����ѵ��
model = svmtrain(train_wine_labels, train_wine, '-c 2 -g 1');

%% SVM����Ԥ��
[predict_label, accuracy] = svmpredict(test_wine_labels, test_wine, model);

%% �������
% ���Լ���ʵ�ʷ����Ԥ�����ͼ
% ͨ��ͼ���Կ���û�в��������Ǳ���ֵ�
figure
plot(test_wine_labels,'o');hold on;
plot(predict_label,'r*');
xlabel('Number of samples','FontSize',12);
ylabel('Category label','FontSize',12);
legend('Real label','Predicted label');
