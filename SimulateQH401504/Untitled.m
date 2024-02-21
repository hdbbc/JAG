tic
clc; 
clear; 
close all;   
    RawMT=load('QH401804TS5HX.dat');
     RawMT=RawMT(134501:139000);
    Length=length(RawMT);
    fs=15;
    t=0:1/fs:(Length-1)/fs;
    f=0:fs*1/Length:fs*(1-1/Length);
    average=sum(RawMT)/length(RawMT) ;
    RawMT=RawMT-average;
    %% MMF处理
    MT_MMF=fcocmk_zhu(RawMT,20,0);
%      MT_MMF(1819:2040)=-262.4;
%      MT_MMF(4339:4488)=-579.4;
%     MT_MMF(10302:10498)=-304.2;
    
    MMF=RawMT-MT_MMF;
    figure
    plot(RawMT,'b');  hold on;
    plot(MT_MMF,'r');hold on;
    set(gca,'FontName','Times New Roman','FontSize',10);xlabel('Time(s)');ylabel('Amplitude');
%     fids1=fopen('QH401504TS5EXMMF.dat', 'wt');%去噪后的高频信号
%     fprintf(fids1,'%10.0f%10.0f',MMF);
%     fclose(fids1);
%     Check=load('QH401504TS5EXMMF.dat');
   toc