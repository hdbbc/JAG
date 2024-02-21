    clc;
    close all;
    clear;
    Noise=load('ChargeNoise.dat');
    x=Noise
    CFDData=zeros(1,2048);
    CFDData(201:400)=1.1*x
    CFDData(601:800)=-0.8*x;
    CFDData(1001:1200)=x;
    CFDData(1401:1600)=0.9*x
    CFDData(1801:2000)=-x
    CFDData=0.03*CFDData;
    
    figure(1)
    subplot(2,1,1);    plot(x);axis([0 2048 -1e+4 1e+4]);
    subplot(2,1,2);    plot(CFDData);axis([0 2048 -1e+4 1e+4]);
        
    fids1 = fopen('ChongfangdianData.dat', 'wt');
    fprintf(fids1, '%10.0f%10.0f', CFDData);
    fclose(fids1);
    fids2= fopen('ChongfangdianNoise.dat', 'wt');
    fprintf(fids2, '%10.0f%10.0f', x);
    fclose(fids2);
