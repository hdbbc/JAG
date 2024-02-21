clc; 
clear; 
close all;
tic
   fs=15;
   x1=load('3087812ATS5EX.dat');
   x2=load('3087812ATS5EXMMFSVMKSVD.dat');
   average1=sum(x1)/length(x1);
   x1=x1-average1;
   x2=x2-average1;
   x3=load('3087812ATS5HY.dat');
   x4=load('3087812ATS5HYMMFSVMKSVD.dat');
   average2=sum(x3)/length(x3);
   x3=x3-average2;
   x4=x4-average2;
   x1=x1(63001:72000);x11=x1(1861:2010);x111=x1(7501:7650);    
   x2=x2(63001:72000);x22=x2(1861:2010);x222=x2(7501:7650);
   x3=x3(631001:640000);x33=x3(151:300);x333=x3(8476:8625);
   x4=x4(631001:640000);x44=x4(151:300);x444=x4(8476:8625);
   Length1=length(x1)
   t1=0:1/fs:(Length1-1)/fs;
   Length11=length(x11)
   t11=0:1/fs:(Length11-1)/fs;
   Length111=length(x111)
   t111=0:1/fs:(Length111-1)/fs;
 figure
   subplot(421)
    plot(t1,x1,'g');hold on;
    plot(t1,x2,'k');hold on;
    legend('Original','MMF-SVM-KSVD');
    xlabel('Time(s)');ylabel('Amplitude')
   subplot(423)
    plot(t11,x11,'g');hold on;
    plot(t11,x22,'k');hold on;
    xlabel('Time(s)');ylabel('Amplitude');
   subplot(424)
    plot(t111,x111,'g');hold on;
    plot(t111,x222,'k');hold on;
    xlabel('Time(s)');ylabel('Amplitude');
    subplot(425)
    plot(t1,x3,'g');hold on;
    plot(t1,x4,'k');hold on;
    legend('Original','MMF-SVM-KSVD');
    xlabel('Time(s)');ylabel('Amplitude')
   subplot(427)
    plot(t11,x33,'g');hold on;
    plot(t11,x44,'k');hold on;
    xlabel('Time(s)');ylabel('Amplitude');
   subplot(428)
    plot(t111,x333,'g');hold on;
    plot(t111,x444,'k');hold on;
    xlabel('Time(s)');ylabel('Amplitude');
toc

    
