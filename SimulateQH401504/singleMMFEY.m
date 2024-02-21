tic
clc; 
clear; 
close all;  
    Original=load('QH401504TS5EY.dat');  
    RawMT=load('QH401504TS5EYSynData.dat');  
    Length=length(RawMT);
    fs=15;
    t=0:1/fs:(Length-1)/fs;
    f=0:fs*1/Length:fs*(1-1/Length);
    average=sum(RawMT)/length(RawMT) ;
    RawMT=RawMT-average;
    %% MMF处理
    MT_MMF=fcocmk_zhu(RawMT,10,0);
    MMF=RawMT-MT_MMF+average;
    figure
    plot(Original,'b');  hold on;
    plot(MMF,'r');hold on;
    set(gca,'FontName','Times New Roman','FontSize',10);xlabel('Time(s)');ylabel('Amplitude');
    fids1=fopen('QH401504TS5EYMMF.dat', 'wt');%去噪后的高频信号
    fprintf(fids1,'%10.0f%10.0f',MMF);
    fclose(fids1);
    Check=load('QH401504TS5EYMMF.dat');
   toc