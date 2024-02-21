%% 清空环境变量
clc
clear
close all
%% 载入信号
tic
clear all;
close all;
clc;
N=150;
fs=150;
tt=0:1/fs:(N-1)/fs;
x1=load('2771709ETS4EY.dat');x1=x1(135001:141000);
x2=load('2771709ETS4EYKSVD-after.dat');x2=x2(135001:141000)
% x1=x1(5001:110000);
x3=load('good.dat');
MTsignal=load('2771709ETS4EY.dat');MTsignal=MTsignal(135001:141000)
x=MTsignal(000+1:000+6000);
k=floor(length(x)/N);
figure
plot(x);
average=sum(MTsignal)/length(MTsignal)
 x=x-average;
data0=yuzhices(x,N,k);%%测试集
data00=xlsread('E.xlsx','B1:M1001');%%训练集
wine=data00(:,1:4);
wine_labels=data00(:,5);
classnumber=2;

%% 清空环境变量
format compact;
%% 数据提取
% 选定训练集和测试集
% 将第一类的1-30,第二类的60-95,第三类的131-153做为训练集
train_wine = [wine(1:1000,:)];
% 相应的训练集的标签也要分离出来
train_wine_labels = [wine_labels(1:1000);];
% 将第一类的31-59,第二类的96-130,第三类的154-178做为测试集
test_wine = [data0(1:k,1:4)];
% 相应的测试集的标签也要分离出来
test_wine_labels = [wine_labels(1:k)];

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
datao=[data0(1:k,1:2),predict_label];
%% 结果分析

% 测试集的实际分类和预测分类图
% 通过图可以看出只有一个测试样本是被错分的
figure;
hold on;
plot(test_wine_labels,'o');
plot(predict_label,'r*');
xlabel('测试集样本','FontSize',12);
ylabel('类别标签','FontSize',12);
legend('实际测试集分类','预测测试集分类');
title('测试集的实际分类和预测分类图','FontSize',12);
grid on;

figure
for i=1:k
    P(i,:)=x(N*(i-1)+1:N*i);
    if(datao(i,3:3)==1)%% 强干扰
%      if(datao(i,9:9)==1)%% 强干扰
      plot((N*(i-1)+1:N*i),P(i,:),'r');axis([ 0 length(x) -max(x) max(x)]);
     else
      plot((N*(i-1)+1:N*i),P(i,:),'b');axis([ 0 length(x) -max(x) max(x)]);
      hold on
   end
end
 figure



 a=zeros(1,30000);
 b=zeros(1,30000);
for i=1:k
    P(i,:)=x(N*(i-1)+1:N*i);
    if(datao(i,3:3)==1) 
        a(N*(i-1)+1:N*i)=P(i,:);
         subplot(4,1,3);
         plot((N*(i-1)+1:N*i),P(i,:),'r');axis([ 0 length(x) -max(x) max(x)]);legend('SVM-Noisy');ylabel('Amplitude');title('(c)');
         hold on
    else
         b(N*(i-1)+1:N*i)=P(i,:);
    subplot(4,1,2); 
    plot((N*(i-1)+1:N*i),P(i,:),'g');axis([ 0 length(x) -max(x) max(x)]);legend('SVM-Good');;ylabel('Amplitude');title('(b)');xlabel('Samples');
         hold on
   end
end
  subplot(4,1,1);
  plot(x1);ylabel('Amplitude');legend('Original');title('(a)');
 subplot(4,1,4);
  plot(x2);xlabel('Samples');ylabel('Amplitude');legend('SVM-KSVD');title('(d)');
fids1 = fopen('good1.dat', 'wt');
    fprintf(fids1, '%10.0f%10.0f',b);
    fclose(fids1);
    Check=load('good1.dat'); 
   