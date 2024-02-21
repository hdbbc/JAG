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
% ��̬�˲���ȡ��Ƶ
    Low_MMF=fcocmk_zhu(RawMT,70,0);
    High=RawMT-Low_MMF;
  figure
    hold on
    plot(t,RawMT);
    plot(t,High,'g');
    plot(t,Low_MMF,'r');
    set(gca,'FontName','Times New Roman','FontSize',10);xlabel('Time(s)');ylabel('Amplitude');
%% ѡȡһ�ν���С��ȥ��
    x=RawMT;
 %% ��������ֵ��matlabȥ�뷽��
    tptr='heursure';
    %rigrsure,heursure,sqtwolog,minimaxi
    sorh='s';
    scal='sln';
    %one,sln,mln
    wname='db6';
    [xd,cxd,lxd]=wden(x,tptr,sorh,scal,18,wname);%xd�����ź�
    WaveletRuan=x-xd;%xx1����ź�     
    set(gca,'FontName','Times New Roman','FontSize',10);xlabel('Time(s)');ylabel('Amplitude');
 %% ����Ӳ��ֵ��matlabȥ�뷽��
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
    MMFWaveletRuan=WaveletRuan+Low_MMF+average;%ȥ���ĸ�Ƶ���ּ��ϵ�Ƶ����   
    MMFWaveletYing=WaveletYing+Low_MMF+average;
  figure
    hold on;
    plot(t,RawMT,'b');hold on;
    plot(t,MMFWaveletRuan,'k');hold on;
    %% ��������
    fids1 = fopen('QH401504TS5EXMMFWaveletRuan.dat', 'wt');%����KSVD�������������ź�
    fprintf(fids1, '%10.0f%10.0f',MMFWaveletRuan);
    fclose(fids1);
    CLzong=load('QH401504TS5EXMMFWaveletRuan.dat');
    fids2 = fopen('QH401504TS5EXMMFWaveletYing.dat', 'wt');%����KSVD�������������ź�
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
    