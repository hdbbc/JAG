clc;
    close all;
    clear on;
    N0=1200;
    N=1200;
    N2=1200;
    
    fs=15;
    t=0:1/fs:(N2-1)/fs;
    t0=0:1/fs:(N0-1)/fs;
    f0=0:fs*1/N0:fs*(1-1/N0);
    f=0:fs*1/N2:fs*(1-1/N2);
    Dataspan=0+1:0+N;
    MTRAW0=load('10-11CTS5EX.dat');
     MTRAW0=MTRAW0(856801:858000);
figure
    plot(MTRAW0)
%     average=sum(MTRAW0)/length(MTRAW0)    %求平均值
%     MTRAW0=MTRAW0-average;                %去除基线
    MTdata=load('10-11CTS5EXsanjiaoboDataMMF-SVM-Noisycontour.dat'); 
%     MTdata=MTdata-average;
    MTRAW=MTRAW0(Dataspan);
    MTSyn=MTdata(Dataspan);
% %% 转换系数    
    FSCV=6.4;   %基准电压
    EGN=10;     %电道放大倍数
    HGN=3;      %磁道放大倍数
    ExLN=170;   % Ex电极距长度
    EXLN=170;   % EX电极距长度
    
    HATT=0.233; %交叉系数
    HNUM=1000;  %比例因子
    Coef_EX=(FSCV/8388608)*(1/EGN)*(1/ExLN)*1000000;    %电道EX的mV/km转换系数
    Coef_EX=(FSCV/8388608)*(1/EGN)*(1/EXLN)*1000000;    %电道EX的mV/km转换系数
    Coef_H=(FSCV/8388608)*(1/HGN)*(1/HATT)*(1000/HNUM); %磁道mV/km转换系数
%% 下载不同方法处理后的结果  
    %% 下载不同方法处理后的结果  
%     MMF=load('10-11CTS5EXSynSanjiaoboDataMMF.dat');
%     MMF=MMF((Dataspan));
%     KSVD=load('10-11CTS5EXSynSanjiaoboDataKSVD.dat');
%     KSVD=KSVD((Dataspan));
%     MMF_Wavelet=load('10-11CTS5EXSynSanjiaoboDataMMFWavelet.dat');
%     MMF_Wavelet=MMF_Wavelet((Dataspan));
%     SVM_KSVD=load('10-11CTS5EXSynSanjiaoboDataSVM-KSVD.dat');
%     SVM_KSVD=SVM_KSVD((Dataspan));
%     MMF_KSVD=load('10-11CTS5EXSynSanjiaoboDataMMFKSVD.dat');
%     MMF_KSVD=MMF_KSVD((Dataspan));    
    MMF_SVM_KSVD=load('10-11CTS5EXsanjiaoboDataMMF-SVM-KSVD.dat');
    MMF_SVM_KSVD=MMF_SVM_KSVD((Dataspan));  
%     snrmsenccsr(MTRAW,MTSyn) 
%     
%     snrmsenccsr(MTRAW,MTSyn)
%     snrmsenccsr(MTRAW,MMF)
%     snrmsenccsr(MTRAW,IOMP)
%     snrmsenccsr(MTRAW,MMF_Wavelet)
%     snrmsenccsr(MTRAW,SVM_KSVD)
%     snrmsenccsr(MTRAW,MMF_KSVD)  

    
%     MTRAW=MTRAW;
%     MTdata=MTdata;
%     MMF=MMF;
%     KSVD=KSVD*Coef_EX;
%     MMF_Wavelet=MMF_Wavelet*Coef_EX;
%     SVM_KSVD=SVM_KSVD*Coef_EX;
%     MMF_KSVD=MMF_KSVD*Coef_EX;
%     MMF_SVM_KSVD=MMF_SVM_KSVD*Coef_EX;
% % figure(4)
%     subplot(611),plot(t,MTRAW),set(gca,'FontName','Times New Roman','FontSize',9),
%     ylabel('EX(mV/km)'),axis([00/15 3750/15 -0.2 0.2]),legend('Noise-free');
%     subplot(612),plot(t,MTdata(Dataspan)),set(gca,'FontName','Times New Roman','FontSize',9),
%     ylabel('EX(mV/km)'),legend('Noisy'),axis([00/15 3750/15 -1 1]);    
%     subplot(613),plot(t,IOMP),set(gca,'FontName','Times New Roman','FontSize',9),
%     ylabel('EX(mV/km)'),legend('SP'),axis([0/15 3750/15 -0.2 0.2]);
%     subplot(614),plot(t,MMF_Wavelet),set(gca,'FontName','Times New Roman','FontSize',9),
%     ylabel('EX(mV/km)'),legend('MMF-Wavelet'),axis([00/15 3750/15 -0.2 0.2]);
%     subplot(615),plot(t,SVM_KSVD),set(gca,'FontName','Times New Roman','FontSize',9),
%     ylabel('EX(mV/km)'),legend('MMF-SP(Harmonic)'),axis([00/15 3750/15 -0.2 0.2]);
%     subplot(616),plot(t,MMF_KSVD),set(gca,'FontName','Times New Roman','FontSize',9),
%     ylabel('EX(mV/km)'),xlabel({'{\it t}/s'}),legend('MMF-SP(Square)'),axis([00/15 3750/15 -0.2 0.2]);
%     
    MTRAWFFT1127=abs(fft(MTRAW,N));
    MTRAWFFT=abs(fft(MTRAW))*2/N2;MTRAWFFT(1)=0;
    MTSynFFT=abs(fft(MTSyn))*2/N2;MTSynFFT(1)=0;
%     MMFFFT=abs(fft(MMF))*2/N2;MMFFFT(1)=0;
%     MTdataFFT=abs(fft(MTdata(Dataspan)))*2/N2;MTdataFFT(1)=0;
%     KSVDFFT=abs(fft(KSVD))*2/N2;KSVDFFT(1)=0;
%     MMF_WaveletFFT=abs(fft(MMF_Wavelet))*2/N2;MMF_WaveletFFT(1)=0;
%     SVM_KSVDFFT=abs(fft(SVM_KSVD))*2/N2;SVM_KSVDFFT(1)=0;
%     MMF_KSVDFFT=abs(fft(MMF_KSVD))*2/N2;MMF_KSVDFFT(1)=0;
    MMF_SVM_KSVDFFT=abs(fft(MMF_SVM_KSVD))*2/N2;MMF_SVM_KSVDFFT(1)=0;
figure(5)
    hold on
    plot(f,MTRAWFFT)
%     plot(f,MTRAWFFT1127,'r')%,axis([0 10.5 0 0.04]);        
figure(99)
subplot(3,2,1),plot(MTRAW0),set(gca,'FontName','Times New Roman','FontSize',10),
    ylabel('Amplitude'),legend('Original');title('(a)');axis([0 1200 -50000 250000]);
subplot(3,2,2),plot(f,MTRAWFFT),set(gca,'FontName','Times New Roman','FontSize',10),
    ylabel('Amplitude'),legend('Original');title('(b)');axis([0 1 0 15000]);
subplot(3,2,3),plot(MTdata),set(gca,'FontName','Times New Roman','FontSize',10),
    ylabel('Amplitude'),legend('Noisecontour');title('(c)');axis([0 1200 -50000 250000]);
subplot(3,2,4),plot(f,MTSynFFT),set(gca,'FontName','Times New Roman','FontSize',10),
    ylabel('Amplitude'),legend('Noisecontour');title('(d)');axis([0 1 0 15000]);
    subplot(3,2,5),plot(MMF_SVM_KSVD),set(gca,'FontName','Times New Roman','FontSize',10),
    ylabel('Amplitude'),legend('MMF-SVM-KSVD');title('(e)');xlabel('Samples');axis([0 1200 -100000 100000]);
subplot(3,2,6),plot(f,MMF_SVM_KSVDFFT),set(gca,'FontName','Times New Roman','FontSize',10),
    ylabel('Amplitude'),legend('MMF-SVM-KSVD');title('(f)');xlabel({'{\it f} / Hz'}),axis([0 1 0 15000]);
    
    
%     figure(100)
%     subplot(9,1,1),plot(f,MTRAWFFT),set(gca,'FontName','Times New Roman','FontSize',9),
%     ylabel('Amplitude'),axis([0 1 0 10]),legend('Noise-free');title('(a)');
%     subplot(9,1,2),plot(f,MTdataFFT),set(gca,'FontName','Times New Roman','FontSize',9),
%     ylabel('Amplitude'),legend('Noisy'),axis([0 1 0 800]); title('(b)');  
%     subplot(9,1,3),plot(f,MMFFFT),set(gca,'FontName','Times New Roman','FontSize',9),
%     ylabel('Amplitude'),legend('MMF'),axis([0 1 0 10]);title('(c)');
%     subplot(9,1,4),plot(f,KSVDFFT),set(gca,'FontName','Times New Roman','FontSize',9),
%     ylabel('Amplitude'),legend('KSVD'),axis([0 1 0 10]);title('(d)');
%     subplot(9,1,5),plot(f,MMF_WaveletFFT),set(gca,'FontName','Times New Roman','FontSize',9),
%     ylabel('Amplitude'),legend('MMF-Wavelet'),axis([0 1 0 10]);title('(e)');
%     subplot(9,1,6),plot(f,SVM_KSVDFFT),set(gca,'FontName','Times New Roman','FontSize',9),
%     ylabel('Amplitude'),legend('SVM-KSVD'),axis([0 1 0 10]);title('(f)');
%     subplot(9,1,7),plot(f,MMF_KSVDFFT),set(gca,'FontName','Times New Roman','FontSize',9),
%     ylabel('Amplitude'),legend('MMF-KSVD'),axis([0 1 0 10]);title('(g)');
%     subplot(9,1,8),plot(f,MMF_SVM_KSVDFFT),set(gca,'FontName','Times New Roman','FontSize',9),
%     ylabel('Amplitude'),legend('MMF-SVM-KSVD'),axis([0 1 0 10]);title('(h)');
%     subplot(9,1,9),plot(f,MMF_SVM_KSVDFFT-MTRAWFFT),set(gca,'FontName','Times New Roman','FontSize',9),
%     ylabel('Amplitude'),xlabel({'{\it f} / Hz'}),legend('Error(MMF-SVM-KSVD)'),axis([0 1 0 10]);title('(i)');