tic;clc;clear;close all;
   
y=load('110-100ATS5HY.dat');
average=mean(y);
figure(1);
    plot(y);    
    set(gca,'FontName','Times New Roman','FontSize',10);
  ylabel('EX（mV/km）');   
    N=length(y);
    fs=15;%采样频率
    t1=0:1/fs:(N-1)/fs;
    f1=0:fs*1/N:fs*(1-1/N);
    Y=fft(y); 
    fft_1=abs(Y);        
    fft_1(1)=0;
     fft_1(3.98*N/fs+1:4.02*N/fs+1)=fft_1(4.02*N/fs+1:4.06*N/fs+1);
     fft_1((15-4.02)*N/fs+1:(15-3.98)*N/fs+1)=fft_1((15-4.06)*N/fs+1:(15-4.02)*N/fs+1);
    angY=angle(Y);   %频域信号的相位，逆变换时要用到
    fftFFT=((fft_1)/N)*2;
    
    figure
    plot(f1,fftFFT);
    axis([0 fs/2 0 max(fftFFT(1:length(y)))*1.1]);
    set(gca,'FontName','Times New Roman','FontSize',10);
     ylabel('Amplitude');%查看频率
    legend('Original');
    vv=fft_1.*exp(1i*angY);
    y1=ifft(vv,N);
    y1=real(y1)+average;
    figure
    plot(y);hold on;
    plot(y1,'r');hold on
    fids1 = fopen('Denoise110-100ATS5HY.dat', 'wt');
    fprintf(fids1, '%10.0f%10.0f',y1);
    fclose(fids1);
    Low_Check=load('Denoise110-100ATS5HY.dat');  
   