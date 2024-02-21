clc; 
clear; 
close all;
tic
   fs=15;
   x1=load('3087812ATS5EX.dat');
   x2=load('3087812ATS5EY.dat');
   x3=load('3087812ATS5HX.dat');
   x4=load('3087812ATS5HY.dat');
     x4=x4(821001:824000);
   figure
   plot(x1);
      figure
   plot(x2);
      figure
   plot(x3);
      figure
   plot(x4);
   