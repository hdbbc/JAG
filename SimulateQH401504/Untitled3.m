tic
close all;
clear all;
clc;
newdata=xlsread('E1.xlsx','B2:E1001');
new_label=xlsread('E1.xlsx','F2:F1001');
svmStruct2 = fitcsvm(newdata,new_label,'KernelFunction','linear'); % ѵ��ģ��
sv2=svmStruct2.SupportVectors; % ���֧������
figure(1)
gscatter(newdata(:,1),newdata(:,2),new_label) % ��������
hold on
plot(sv2(:,1),sv2(:,2),'ko','MarkerSize',10) % ����֧������
hold on
% ���Ʒ��೬ƽ��
x=-4:0.5:4;
a=-svmStruct2.Beta(1)/svmStruct2.Beta(2);
b=-svmStruct2.Bias/svmStruct2.Beta(2);
Y=a*x+b-0.5;    % ������೬ƽ��
Y2=Y+0.75/svmStruct2.Beta(2);
Y3=Y-0.75/svmStruct2.Beta(2);
plot(x,Y,'k-',x,Y2,'k--',x,Y3,'k--','MarkerSize',10)
legend('Data with strong interference','Data without interference','Support Vector','Hyperplane','Geometric interval')
title('�����׾����SVM����')