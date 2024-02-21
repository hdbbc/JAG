%%曲线对比
tic;clc;clear;close all;
   fs=15;Fs=15;
   N=4500;	
   t=0:1/fs:(N-1)/fs;
   f=0:fs*1/N:fs*(1-1/N);
   N=4500;
   x0=load('QH401504TS5EXSynData.dat');
   x0=x0(334501:339000);
   x1=load('QH401504TS5EY.dat');
   average=sum(x1)/length(x1);
   x1=x1-average;
   x0=x0-average;
   x2=load('QH401504TS5EYMMF.dat');x2=x2-1500-average;
   x3=load('QH401504TS5EYKSVD.dat');x3=x3-3000-average;
   x4=load('QH401504TS5EYSVMKSVD.dat');x4=x4-4500-average;
   x5=load('QH401504TS5EYMMFWaveletRuan.dat');x5=x5-6000-average;
   x6=load('QH401504TS5EYMMFWaveletYing.dat');x6=x6-7500-average;
   x7=load('QH401504TS5EYMMFKSVD.dat');x7=x7-9000-average;
   x8=load('QH401504TS5EYMMFSVMKSVD.dat');x8=x8-10500-average;
   x1=x1(334501:339000);x11=x1(551:700);x111=x1(2701:2850);    
   x2=x2(334501:339000);x22=x2(551:700);x222=x2(2701:2850);
   x3=x3(334501:339000);x33=x3(551:700);x333=x3(2701:2850);
   x4=x4(334501:339000);x44=x4(551:700);x444=x4(2701:2850);
   x5=x5(334501:339000);x55=x5(551:700);x555=x5(2701:2850);
   x6=x6(334501:339000);x66=x6(551:700);x666=x6(2701:2850);
   x7=x7(334501:339000);x77=x7(551:700);x777=x7(2701:2850);
   x8=x8(334501:339000);x88=x8(551:700);x888=x8(2701:2850);
   Length1=length(x1)
   t1=0:1/fs:(Length1-1)/fs;
   Length11=length(x11)
   t11=0:1/fs:(Length11-1)/fs;
   Length111=length(x111)
   t111=0:1/fs:(Length111-1)/fs;
 figure
   subplot(421)
    plot(t1,x1,'b');hold on;
    plot(t1,x2,'m');hold on;
    plot(t1,x3,'y');hold on;
    plot(t1,x4,'g');hold on;
    plot(t1,x5,'r');hold on;
    plot(t1,x6,'k');hold on;
    plot(t1,x7,'r');hold on;
    plot(t1,x8,'k');hold on;
    legend('Original');
    xlabel('Time(s)');ylabel('Amplitude')
   subplot(422)
    plot(t11,x22,'m');hold on;
    plot(t11,x11,'b');hold on;
    plot(t11,x33,'y');hold on;
    plot(t11,x44,'g');hold on;
    plot(t11,x55,'r');hold on;
    plot(t11,x66,'k');hold on;
    plot(t11,x77,'r');hold on;
    plot(t11,x88,'k');hold on;
    legend('MMF');
    xlabel('Time(s)');ylabel('Amplitude');
   subplot(423)
    plot(t111,x333,'y');hold on;
    plot(t111,x111,'b');hold on;
    plot(t111,x222,'m');hold on;
    plot(t111,x444,'g');hold on;
    plot(t111,x555,'r');hold on;
    plot(t111,x666,'k');hold on;
    plot(t111,x777,'r');hold on;
    plot(t111,x888,'k');hold on;
    legend('KSVD');
    xlabel('Time(s)');ylabel('Amplitude');
    subplot(424)
    plot(t1,x4,'g');hold on;
    plot(t1,x1,'b');hold on;
    plot(t1,x2,'m');hold on;
    plot(t1,x3,'y');hold on;
    plot(t1,x5,'r');hold on;
    plot(t1,x6,'k');hold on;
    legend('SVM-KSVD');
    xlabel('Time(s)');ylabel('Amplitude')
   subplot(425)
    plot(t11,x55,'r');hold on;
    plot(t11,x11,'b');hold on;
    plot(t11,x22,'m');hold on;
    plot(t11,x33,'y');hold on;
    plot(t11,x44,'g');hold on;
    plot(t11,x66,'k');hold on;
    legend('MMF-Wavelet-ST');
    xlabel('Time(s)');ylabel('Amplitude');
   subplot(426)
    plot(t111,x666,'k');hold on;
    plot(t111,x111,'b');hold on;
    plot(t111,x222,'m');hold on;
    plot(t111,x333,'y');hold on;
    plot(t111,x444,'g');hold on;
    plot(t111,x555,'r');hold on;
    legend('MMF-Wavelet-HT');
    xlabel('Time(s)');ylabel('Amplitude');
     subplot(427)
    plot(t11,x77,'r');hold on;
    plot(t11,x11,'b');hold on;
    plot(t11,x22,'m');hold on;
    plot(t11,x33,'y');hold on;
    plot(t11,x44,'g');hold on;
    plot(t11,x66,'k');hold on;
    legend('MMF-KSVD');
    xlabel('Time(s)');ylabel('Amplitude');
   subplot(428)
    plot(t111,x888,'k');hold on;
    plot(t111,x111,'b');hold on;
    plot(t111,x222,'m');hold on;
    plot(t111,x333,'y');hold on;
    plot(t111,x444,'g');hold on;
    plot(t111,x555,'r');hold on;
    legend('MMF-SVM-KSVD');
    xlabel('Time(s)');ylabel('Amplitude');
    figure(2)
    x00=fft(x0); %原始信号
    fft_1=abs(x00);        
    fft_1(1)=0;
    angx00=angle(x00);   %频域信号的相位，逆变换时要用到
    fftFFT0=(abs(fft(x0))/N)*2;
    x11=fft(x1); %原始信号
    fft_1=abs(x11);        
    fft_1(1)=0;
    angx11=angle(x11);   %频域信号的相位，逆变换时要用到
    fftFFT1=(abs(fft(x1))/N)*2;
    x22=fft(x2); %原始信号
    fft_2=abs(x22);        
    fft_2(1)=0;
    angx22=angle(x22);   %频域信号的相位，逆变换时要用到
    fftFFT2=(abs(fft(x2))/N)*2;
    x33=fft(x3); %原始信号
    fft_3=abs(x33);        
    fft_3(1)=0;
    angx33=angle(x33);   %频域信号的相位，逆变换时要用到
    fftFFT3=(abs(fft(x3))/N)*2;
    x44=fft(x4); %原始信号
    fft_4=abs(x44);        
    fft_4(1)=0;
    angx44=angle(x44);   %频域信号的相位，逆变换时要用到
    fftFFT4=(abs(fft(x4))/N)*2;
    x55=fft(x5); %原始信号
    fft_5=abs(x55);        
    fft_5(1)=0;
    angx55=angle(x55);   %频域信号的相位，逆变换时要用到
    fftFFT5=(abs(fft(x5))/N)*2;
    x66=fft(x6); %原始信号
    fft_6=abs(x66);        
    fft_6(1)=0;
    angx66=angle(x66);   %频域信号的相位，逆变换时要用到
    fftFFT6=(abs(fft(x6))/N)*2;
    x77=fft(x7); %原始信号
    fft_7=abs(x77);        
    fft_7(1)=0;
    angx77=angle(x77);   %频域信号的相位，逆变换时要用到
    fftFFT7=(abs(fft(x7))/N)*2;
    x88=fft(x8); %原始信号
    fft_8=abs(x88);        
    fft_8(1)=0;
    angx88=angle(x88);   %频域信号的相位，逆变换时要用到
    fftFFT8=(abs(fft(x8))/N)*2;
    hold on;
    figure(100)
    subplot(911)
    plot(f,fftFFT1,'b');%频域
    set(gca,'FontName','Times New Roman','FontSize',10);
    ylabel('Amplitude');%查看频率
    legend('Original');
    axis([0 fs/2 0 max(fftFFT1(1:length(x1)))*1.1]);
    subplot(912)
    plot(f,fftFFT0,'b');%频域
    set(gca,'FontName','Times New Roman','FontSize',10);
    ylabel('Amplitude');%查看频率
    legend('Noisy');
    axis([0 fs/2 0 max(fftFFT1(1:length(x0)))*1.1]);
    subplot(913)
    plot(f,fftFFT2,'b');%频域
    set(gca,'FontName','Times New Roman','FontSize',10);
    ylabel('Amplitude');%查看频率
    legend('MMF');
    axis([0 fs/2 0 max(fftFFT2(1:length(x2)))*1.1]);
    subplot(914)
    plot(f,fftFFT3,'k');%频域
    set(gca,'FontName','Times New Roman','FontSize',10);
    ylabel('Amplitude');%查看频率
    legend('KSVD');
     axis([0 fs/2 0 max(fftFFT1(1:length(x1)))*1.1]);
    subplot(915)
    plot(f,fftFFT4,'b');%频域
    set(gca,'FontName','Times New Roman','FontSize',10);
    ylabel('Amplitude');%查看频率
    legend('SVM-KSVD');
    axis([0 fs/2 0 max(fftFFT1(1:length(x1)))*1.1]);
    subplot(916)
    plot(f,fftFFT5,'b');%频域
    set(gca,'FontName','Times New Roman','FontSize',10);
    ylabel('Amplitude');%查看频率
    legend('MMF-Wavelet-ST');
    axis([0 fs/2 0 max(fftFFT1(1:length(x1)))*1.1]);
    subplot(917)
    plot(f,fftFFT6,'k');%频域
    set(gca,'FontName','Times New Roman','FontSize',10);
    ylabel('Amplitude');%查看频率
    legend('MMF-Wavelet-HT');
    axis([0 fs/2 0 max(fftFFT1(1:length(x1)))*1.1]);
    subplot(918)
    plot(f,fftFFT7,'b');%频域
    set(gca,'FontName','Times New Roman','FontSize',10);
    ylabel('Amplitude');%查看频率
    legend('MMF-KSVD');
    axis([0 fs/2 0 max(fftFFT1(1:length(x1)))*1.1]);
    subplot(919)
    plot(f,fftFFT8,'k');%频域
    set(gca,'FontName','Times New Roman','FontSize',10);
    ylabel('Amplitude');%查看频率
    legend('MMF-SVM-KSVD');
    axis([0 fs/2 0 max(fftFFT1(1:length(x1)))*1.1]);
   
toc