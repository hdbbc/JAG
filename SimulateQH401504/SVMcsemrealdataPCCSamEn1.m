%% ��ջ�������
clc
clear
close all
%% �����ź�
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
data0=yuzhices(x,N,k);%%���Լ�
data00=xlsread('E.xlsx','B1:M1001');%%ѵ����
wine=data00(:,1:4);
wine_labels=data00(:,5);
classnumber=2;

%% ��ջ�������
format compact;
%% ������ȡ
% ѡ��ѵ�����Ͳ��Լ�
% ����һ���1-30,�ڶ����60-95,�������131-153��Ϊѵ����
train_wine = [wine(1:1000,:)];
% ��Ӧ��ѵ�����ı�ǩҲҪ�������
train_wine_labels = [wine_labels(1:1000);];
% ����һ���31-59,�ڶ����96-130,�������154-178��Ϊ���Լ�
test_wine = [data0(1:k,1:4)];
% ��Ӧ�Ĳ��Լ��ı�ǩҲҪ�������
test_wine_labels = [wine_labels(1:k)];

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
datao=[data0(1:k,1:2),predict_label];
%% �������

% ���Լ���ʵ�ʷ����Ԥ�����ͼ
% ͨ��ͼ���Կ���ֻ��һ�����������Ǳ���ֵ�
figure;
hold on;
plot(test_wine_labels,'o');
plot(predict_label,'r*');
xlabel('���Լ�����','FontSize',12);
ylabel('����ǩ','FontSize',12);
legend('ʵ�ʲ��Լ�����','Ԥ����Լ�����');
title('���Լ���ʵ�ʷ����Ԥ�����ͼ','FontSize',12);
grid on;

figure
for i=1:k
    P(i,:)=x(N*(i-1)+1:N*i);
    if(datao(i,3:3)==1)%% ǿ����
%      if(datao(i,9:9)==1)%% ǿ����
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
   