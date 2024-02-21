%% 载入信号
 clc; clear; close all;
 tic   
N=15000;
fs=15; 
 MTn=load('QH401804TS5EY.dat');
 x1=load('QH401804TS5EYMMF-SVM-KSVD-1.dat');
%  x2=load('QH401804TS5EYMMF-SVM-KSVD-2.dat');
%  x3=load('QH401804TS5EYMMF-SVM-KSVD-3.dat');
%  x4=load('QH401804TS5EYMMF-SVM-KSVD-4.dat');
%  x5=load('QH401804TS5EYMMF-SVM-KSVD-5.dat');
%  x6=load('QH401804TS5EYMMF-SVM-KSVD-6.dat');
 MTn(50001:200000)=x1;
%  MTn(155001:305000)=x2;
%  MTn(305001:455000)=x3;
%  MTn(455001:605000)=x4;
%  MTn(605001:755000)=x5;
%  MTn(755001:905000)=x6;
%  MTn(750051:900050)=x4;
 MT=load('QH401804TS5EY.dat');
 figure
 plot(MT,'b'); hold on;
 plot(MTn,'r');  hold on;
 fids1 = fopen('QH401804TS5EYMMF-SVM-KSVD.dat', 'wt');%保存去噪信号
    fprintf(fids1, '%10.0f%10.0f', MTn);
    fclose(fids1)
 toc