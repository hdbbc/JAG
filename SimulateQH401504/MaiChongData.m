%改自jianyan
clear;close all;clc;
N=2048;%计算的点数
fs=1024;
t=0:1/fs:(N-1)/fs;

x=zeros(1,2048);
ran=randperm(N);

for i=1:20
    x(ran(i))=x(ran(i))+(-1)^i*(rand(1,1)+1);
end

f=0:fs*1/N:fs*(1-1/N);
 XieboData=x*3000;
      fids1 = fopen('MaiChongData.dat', 'wt');
      fprintf(fids1, '%10.0f%10.0f', XieboData);
      fclose(fids1);
xieb=load('MaiChongData.dat');
figure(20)
plot(xieb)
toc
