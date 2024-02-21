%% 载入信号
tic
    clear all;
    close all;
    clc;
    Step=4500;
    Noise=load('DifferntNoiseData.dat');
    TS5EX=load('QH401504TS5EX.dat');
    TS5EY=load('QH401504TS5EY.dat');
    TS5EySyn=TS5EY; 
    TS5ExSyn=TS5EX;    Dataspan1=300001:750000;
    MTSynNoise=zeros(1,450000);
for i=0:1:99
    MTSynNoise(i*Step+1:(i+1)*Step)=MTSynNoise(i*Step+1:(i+1)*Step)+Noise;
end
    TS5EySyn(Dataspan1)=TS5EySyn(Dataspan1)+MTSynNoise;%给EY道加噪声
    TS5ExSyn(Dataspan1)=TS5ExSyn(Dataspan1)+MTSynNoise;%给EX道加噪声
figure(3)
    hold on
    plot(TS5EX,'g');
    plot(TS5ExSyn,'r');
figure(4)
    hold on
    plot(TS5EY,'g');
    plot(TS5EySyn,'r');
  a=TS5EY(334501:339000);
   average=sum(a)/length(a);
  a=a-average;
  b=TS5EySyn(334501:339000);b=b-average;
  c=b-a;
  figure
  subplot(311)
   plot(a,'b');xlabel('Time(s)');ylabel('Amplitude')
  subplot(312)
   plot(c,'b');xlabel('Time(s)');ylabel('Amplitude')
   subplot(313)
   plot(b,'b');xlabel('Time(s)');ylabel('Amplitude')
%  保存加噪后数据
    fids1 = fopen('QH401504TS5EXSynData.dat', 'wt');%QH401504TS5EYCL1的1：16384个数据已处理
    fprintf(fids1, '%10.0f%10.0f', TS5ExSyn);
    fclose(fids1);
    fids1 = fopen('QH401504TS5EYSynData.dat', 'wt');%QH401504TS5EYCL1的1：16384个数据已处理
    fprintf(fids1, '%10.0f%10.0f', TS5EySyn);
    fclose(fids1);
toc

