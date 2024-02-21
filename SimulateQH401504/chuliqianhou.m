%% ‘ÿ»Î–≈∫≈
tic
clear all;
close all;clc;
x1=load('100-102ATS5EY.dat');
figure
%  x1=x1(188001:191000);
    plot(x1,'b');hold on;
%     plot(x11,'r')
    xlabel('Samples');ylabel('Amplitude of Ex');
  legend('Noisy'); 
%  subplot(212)   
%     plot(x11,'r');hold on;
%   xlabel('Samples');ylabel('Amplitude of Ex');
%   legend('MMF-SVM-KSVD'); 
% figure
%     plot(x2) ;hold on;
%     plot(x22,'r');hold on;
%    xlabel('Samples');ylabel('Amplitude of Ey');
%     legend('Noisy','MMF-SVM-KSVD'); 
% figure
%     plot(x3) ;hold on;
%     plot(x33,'r');hold on;
%    xlabel('Samples');ylabel('Amplitude of Hx');
%     legend('Noisy','MMF-SVM-KSVD'); 
%  figure
%      subplot(211)
%      plot(x4) ;hold on;
%      xlabel('Samples');ylabel('Amplitude of Hy');
%     legend('Noisy'); 
%      subplot(212)
%     plot(x44,'r');hold on;
%    xlabel('Samples');ylabel('Amplitude of Hy');
%     legend('MMF-SVM-KSVD'); 
   toc