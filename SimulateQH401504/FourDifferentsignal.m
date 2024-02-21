clc; clear; close all;
    tic
    x1=load('EGood1-100.dat'); x1=x1(1:150);
    x2=load('ENoisy77.dat');
    x3=load('ENoisy474.dat'); 
    x4=load('ENoisy226.dat'); 
 Length=length(x1);
    fs=15;
    t=0:1/fs:(Length-1)/fs;
    f=0:fs*1/Length:fs*(1-1/Length);
    figure
    subplot(221)
    plot(x1,'b');legend('Good'); xlabel('Samples');ylabel('Amplitude');title('(a)');
    subplot(222)
    plot(x2,'b');legend('Charge-Discharge'); xlabel('Samples');ylabel('Amplitude');title('(b)');
    subplot(223)
    plot(x3,'b');legend('Square-wave'); xlabel('Samples');ylabel('Amplitude');title('(c)');
    subplot(224)
    plot(x4,'b');legend('Pulse'); xlabel('Samples');ylabel('Amplitude');title('(d)');
    toc