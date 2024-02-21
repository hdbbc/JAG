%% 载入信号
tic
    clear all;
    close all;
    clc;
    N=4500;N2=4500;N3=225;
    fs=15;
    t=0:1/fs:(N-1)/fs;
    t2=0:1/fs:(N2-1)/fs;
    t3=0:1/fs:(N3-1)/fs;
    f=0:fs*1/N:fs*(1-1/N);
    f2=0:fs*1/N2:fs*(1-1/N2);
    %% Load data
    MT=load('QH401504TS5EY.dat');
    MT=MT(334501:339000);
    MTRAW=load('QH401504TS5EYSynDifferentNoiseData.dat');
    MTRAW=MTRAW(334501:339000);
    Noisy=MTRAW-MT;
    average=sum(MT)/length(MT) %求平均值
    MT=MT-average;  
    MTRAW=MTRAW-average;                %去除基线
    MTdata=load('QH401504TS5EYSynDifferentNoiseData.dat');
    MTdata=MTdata(334501:339000);
    MTdata=MTdata-average;
    N1=4500;
    Dataspan=334500+1:334500+N1;
    %% Wavelet  
    [c,l]=wavedec(MTdata,5,'bior4.4');
    a5=wrcoef('a',c,l,'bior4.4',5);%重构各层逼近信息
    a4=wrcoef('a',c,l,'bior4.4',4);%重构各层逼近信息
    a3=wrcoef('a',c,l,'bior4.4',3);
    a2=wrcoef('a',c,l,'bior4.4',2);
    a1=wrcoef('a',c,l,'bior4.4',1);
 %% MMF
    LowWave_MMF=fcocmk_zhu(MTdata,70,0);
    g=ones(1,80); 
    Wave_MMFLJ=xtdy(MTRAW,g);
%% CEEMD
    IMF1=ceemd(MTdata,0.2,4,8);
    [a,b]=size(IMF1)
    imf1=IMF1(:,b);
    imf2=IMF1(:,b-1);
    imf3=IMF1(:,b-2);
    imf4=IMF1(:,b-3);
    imf5=IMF1(:,b-4);
    imf6=IMF1(:,b-5);
    imf7=IMF1(:,b-6);
    imf8=IMF1(:,b-7);
figure
    subplot(811);plot(imf1),set(gca,'FontName','Times New Roman','FontSize',9);hold on,    ylabel('IMF1')
    subplot(812);plot(imf2),set(gca,'FontName','Times New Roman','FontSize',9);hold on;    ylabel('IMF2')
    subplot(813);plot(imf3),set(gca,'FontName','Times New Roman','FontSize',9);hold on;    ylabel('IMF2')
    subplot(814);plot(imf4),set(gca,'FontName','Times New Roman','FontSize',9);hold on;    xlabel('Samples'),ylabel('Res.')
    subplot(815);plot(imf5),set(gca,'FontName','Times New Roman','FontSize',9);hold on,    ylabel('Signal')
    subplot(816);plot(imf6),set(gca,'FontName','Times New Roman','FontSize',9);hold on;    ylabel('IMF1')
    subplot(817);plot(imf7),set(gca,'FontName','Times New Roman','FontSize',9);hold on;    ylabel('IMF2')
    subplot(818);plot(imf8),set(gca,'FontName','Times New Roman','FontSize',9);hold on;    xlabel('Samples'),ylabel('Res.')
    Low_CEEMD=imf1+imf2+imf3+imf4+imf5+imf6+imf7;
%% VMD
    [u,u_hat,omega] = VMD(MTdata,1000,0,3,0,1,1e-10); %IMF
    a=3;
    figure(1);
    imfn=u;
    imf1=u(1,:);
    imf2=u(2,:);
    imf3=u(3,:);
figure
    subplot(311);plot(imf1),set(gca,'FontName','Times New Roman','FontSize',9);hold on;   
    subplot(312);plot(imf2),set(gca,'FontName','Times New Roman','FontSize',9);hold on;    
    subplot(313);plot(imf3),set(gca,'FontName','Times New Roman','FontSize',9);hold on;    
    Low_VMD=imf1+imf2;
 %%
figure
hold on
    box on,
    subplot(421)
    plot(t,MT,'k'); hold on;
    xlabel({'Time(s)'}),ylabel('Amplitude'),legend('Original');
    subplot(422)
    plot(t,Noisy,'r'); hold on;
    xlabel({'Time(s)'}),ylabel('Amplitude'),legend('Noise');
    subplot(423)
    plot(t,MTdata,'r'); hold on;
    plot(t,Low_CEEMD,'g');hold on;
    plot(t,a5,'m');hold on;
    plot(t,Low_VMD,'y');hold on;
    plot(t,LowWave_MMF,'k');hold on;
    xlabel({'Time(s)'}),ylabel('Amplitude'),legend('Noisy','CEEMD','Wavelet','VMD','MMF');
    
    MTdata1=MTdata(526:750);
    Low_CEEMD1=Low_CEEMD(526:750);
    a51=a5(526:750);
    Low_VMD1=Low_VMD(526:750);
    LowWave_MMF1=LowWave_MMF(526:750);
    subplot(223)
    plot(t3,MTdata1,'r'); hold on;
    plot(t3,Low_CEEMD1,'g');hold on;
    plot(t3,a51,'m');hold on;
    plot(t3,Low_VMD1,'y');hold on;
    plot(t3,LowWave_MMF1,'k');hold on;
    xlabel({'Time(s)'}),ylabel('Amplitude');
    MTdata2=MTdata(3151:3375);
    Low_CEEMD2=Low_CEEMD(3151:3375);
    a52=a5(3151:3375);
    Low_VMD2=Low_VMD(3151:3375);
    LowWave_MMF2=LowWave_MMF(3151:3375);
    subplot(224)
    plot(t3,MTdata2,'r'); hold on;
    plot(t3,Low_CEEMD2,'g');hold on;
    plot(t3,a52,'m');hold on;
    plot(t3,Low_VMD2,'y');hold on;
    plot(t3,LowWave_MMF2,'k');hold on;
    xlabel({'Time(s)'}),ylabel('Amplitude');
toc