    clc;
    clear;
    Fs = 10000;  
    t = 0:1/Fs:1.5;  
    x = sawtooth(2*pi*100*t); 
    SJBData=zeros(1,2048);
    SJBData(201:400)=-1*x(1:200); SJBData(251:300)=0;SJBData(301:350)=0;
    SJBData(701:900)=1*x(1:200);SJBData(751:800)=0;SJBData(801:850)=0;
    SJBData(1201:1400)=-1*x(1:200);SJBData(1251:1300)=0;SJBData(1301:1350)=0;
    SJBData(1701:1900)=1*x(1:200);SJBData(1751:1800)=0;SJBData(1801:1850)=0;
    SJBData=4000*SJBData;
    x=4000*x;
    figure(1)
    subplot(2,1,1);    plot(x);axis([0 2000 -1e+4 1e+4]);
    subplot(2,1,2);    plot(SJBData);axis([0 2000 -1e+4 1e+4]);
        
    fids1 = fopen('SanjiaoboData.dat', 'wt');
    fprintf(fids1, '%10.0f%10.0f', SJBData);
    fclose(fids1);
    x=SJBData(151:350);
    fids2 = fopen('SanjiaoboNoise.dat', 'wt');
    fprintf(fids2, '%10.0f%10.0f', x);
    fclose(fids2);
    toc

