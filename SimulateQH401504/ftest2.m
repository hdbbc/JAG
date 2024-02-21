tic
close all;tic
clear all;
clc;
addpath('tftoolbox');%%添加时频工具箱的路径
N=10000;%%信号长度
fs=150;
dt=1;%%采样步长
t=0:1/fs:(N-1)/fs;
f=0:fs*1/N:fs*(1-1/N);
% x=load('JianMaiChong3.dat');
% zaoyin = awgn(x,10,'measured')-x;
% x1=x+zaoyin;
% figure(1);
% subplot(2,1,1);plot(x);
% subplot(2,1,2);plot(x1,'r')
 

%ksvd电磁去噪
x=load('JianMaiChong3.dat');
zaoyin=awgn(x,10,'measured')-x;
x1=x+zaoyin
M=max(abs(zaoyin))
fprintf('M = %.2f\n',M)
figure(1);
subplot(3,1,1);plot(x);
subplot(3,1,2);plot(zaoyin);
subplot(3,1,3);plot(x1);
origSignal=x1;
signal_2 = (sum(origSignal(:).^2));
figure(2);
subplot(3,1,1);plot(origSignal);
subplot(3,1,2);plot(x);

Data  		= im2colstep(x1, [1, 16], [1, 1]);
rperm 		= randperm(size(Data, 2));
patchData 	= Data(:, rperm(1:800));%%800样本数量

param.L = 10;   % number of elements in each linear combination.
param.displayProgress = 1;  
param.InitializationMethod =  'DataElements';
param.errorFlag = 1; % decompose signals until a certain error is reached. do not use fix number of coefficients.
param.errorGoal = 0; 
param.preserveDCAtom = 1;
param.numIteration = 1; % number of iteration to execute the K-SVD algorithm.
param.K = 800;  % number of dictionary elements
tic

[Dictionary,output]  =KSVD(patchData,param);
toc
a=OMPerr(Dictionary,Data ,M+1); %2 %4 %3
y=Dictionary*a;

A = col2imstep(y,size(x1),[1 16],[1 1]);% 90  106 120
Y = countcover(size(x1) ,[1 16],[1 1]);% 90  106 120
dnoise=A./Y;

ncc=sum(x.*dnoise)/sqrt((sum(x.*x)*(sum(dnoise.*dnoise))))
E=norm(x-dnoise)/norm(x) 
snr=20*log10(norm(x)/norm(x-dnoise))

figure(15);
subplot(311),
plot(x1,'b');set(gca,'FontName','Times New Roman','FontSize',8);
xlabel('Sampling points'),ylabel('Amp');box on;
subplot(312),
plot(dnoise,'b');set(gca,'FontName','Times New Roman','FontSize',8);
xlabel('Sampling points'),ylabel('Amp');box on;
subplot(313),plot(x1-dnoise,'r');set(gca,'FontName','Times New Roman','FontSize',8); 
xlabel('Sampling points');

 X1=fft(x1); 
    fft_1=abs(X1);        
    fft_1(1)=0;
     figure(2)  
    [B,f,t]=specgram(x1,40,1/dt,hamming(40),20);
    figure(22)
  pcolor(t,f,abs(B));
    shading interp
    colorbar %加上色标
    figure(3)
    mesh(t,f,abs(B))
     xlabel('时间/s'),ylabel('频率/HZ');
    
 X2=fft(dnoise); 
    fft_1=abs(X2);        
    fft_1(1)=0;
    [C,f,t]=specgram(dnoise,40,1/dt,hamming(40),20);
    figure(4)
  pcolor(t,f,abs(C));
    shading interp
    colorbar %加上色标
    figure(5)
    mesh(t,f,abs(C))
     xlabel('时间/s'),ylabel('频率/HZ');zlabel('幅度');%axis([0 1024 0 0.8 0 25])

 X=fft(x); 
    fft_1=abs(X);        
    fft_1(1)=0;
   
    [D,f,t]=specgram(x,40,1/dt,hamming(40),20);
    figure(50)
  pcolor(t,f,abs(D));
    shading interp
    colorbar %加上色标
    X=fft(zaoyin); 
    fft_1=abs(X);        
    fft_1(1)=0;
   
    [E,f,t]=specgram(x1-dnoise,40,1/dt,hamming(40),20);
    figure(55)
  pcolor(t,f,abs(E));
    shading interp
    colorbar %加上色标
toc