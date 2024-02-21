clc; 
    clear; 
    close all;
    tic
    OriginalMT=load('QH401504TS5EX.dat');
    RawMT=load('QH401504TS5EXSynData.dat');
    average=sum(RawMT)/length(RawMT);
    RawMT=RawMT-average;
    Length=length(RawMT);
    N=Length;
    fs=15;
    Length=length(RawMT);
    fs=15;
    t=0:1/fs:(Length-1)/fs;
% 形态滤波提取低频
    Low_MMF=fcocmk_zhu(RawMT,70,0);
    High=RawMT-Low_MMF;
  figure
    hold on
    plot(t,RawMT);
    plot(t,High,'g');
    plot(t,Low_MMF,'r');
    set(gca,'FontName','Times New Roman','FontSize',10);xlabel('Time(s)');ylabel('Amplitude');
%% 选取一段进行小波去噪
    x=RawMT;
 %% 采用软阈值的matlab去噪方法
    tptr='heursure';
    %rigrsure,heursure,sqtwolog,minimaxi
    sorh='s';
    scal='sln';
    %one,sln,mln
    wname='db6';
    [xd,cxd,lxd]=wden(x,tptr,sorh,scal,18,wname);%xd输入信号
    WaveletRuan=x-xd;%xx1输出信号     
    set(gca,'FontName','Times New Roman','FontSize',10);xlabel('Time(s)');ylabel('Amplitude');
 %% 采用硬阈值的matlab去噪方法
    tptr='heursure';
    %rigrsure,heursure,sqtwolog,minimaxi
    sorh='h';
    scal='sln';
    %one,sln,mln
    wname='db6';
    [xd2,cxd,lxd]=wden(x,tptr,sorh,scal,6,wname);
    WaveletYing=x-xd2;    
  figure
    hold on;
    subplot(311),plot(t,RawMT);
    subplot(312),plot(t,WaveletYing,'r');   
    subplot(313),plot(t,WaveletRuan,'g');
    set(gca,'FontName','Times New Roman','FontSize',10);xlabel('Time(s)');ylabel('Amplitude');
    MMFWaveletRuan=WaveletRuan+Low_MMF+average;%去噪后的高频部分加上低频部分   
    MMFWaveletYing=WaveletYing+Low_MMF+average;
  figure
    hold on;
    plot(t,RawMT,'b');hold on;
    plot(t,MMFWaveletRuan,'k');hold on;
    %% 保存数据
    fids1 = fopen('QH401504TS5EXMMFWaveletRuan.dat', 'wt');%保存KSVD处理后的噪声的信号
    fprintf(fids1, '%10.0f%10.0f',MMFWaveletRuan);
    fclose(fids1);
    CLzong=load('QH401504TS5EXMMFWaveletRuan.dat');
    fids2 = fopen('QH401504TS5EXMMFWaveletYing.dat', 'wt');%保存KSVD处理后的噪声的信号
    fprintf(fids2, '%10.0f%10.0f',MMFWaveletYing);
    fclose(fids2);
    CLzong=load('QH401504TS5EXMMFWaveletYing.dat');
  figure
    plot(t,MMFWaveletRuan,'b');hold on;
    plot(t,OriginalMT,'r');hold on;
    set(gca,'FontName','Times New Roman','FontSize',10);xlabel('Time(s)');ylabel('Amplitude');
  figure
    plot(t,MMFWaveletYing,'b');hold on;
    plot(t,OriginalMT,'r');hold on;
    set(gca,'FontName','Times New Roman','FontSize',10);xlabel('Time(s)');ylabel('Amplitude');
   toc
    