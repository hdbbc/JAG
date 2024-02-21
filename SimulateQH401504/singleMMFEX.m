tic
clc; 
clear; 
close all;  
    Original=load('QH401504TS5EX.dat');  
    RawMT=load('QH401504TS5EXSynData.dat');  
    Length=length(RawMT);
    fs=15;
    t=0:1/fs:(Length-1)/fs;
    f=0:fs*1/Length:fs*(1-1/Length);
    average=sum(RawMT)/length(RawMT) ;
    RawMT=RawMT-average;
    %% MMF处理
    MT_MMF=fcocmk_zhu(RawMT,70,0);
    High=RawMT-MT_MMF;
    MMF=fcocmk_zhu(High,5,0);
    MMF=High-MMF;
    MTMMF=MT_MMF+MMF+average;
    figure
    plot(Original,'b');  hold on;
    plot(MTMMF,'r');hold on;
    set(gca,'FontName','Times New Roman','FontSize',10);xlabel('Time(s)');ylabel('Amplitude');
    fids1=fopen('QH401504TS5EXMMF.dat', 'wt');%去噪后的高频信号
    fprintf(fids1,'%10.0f%10.0f',MTMMF);
    fclose(fids1);
    Check=load('QH401504TS5EXMMF.dat');
   toc