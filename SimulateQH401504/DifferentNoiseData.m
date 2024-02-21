clc;
clear;
x1=load('ChongfangdianNoise.dat');
x2=load('SanjiaoboNoise.dat');
x3=load('MaiChongNoise.dat');
x3(701:900)=x1*0.04;
x3(1701:1900)=x2;
x3(2301:2365)=x3(2301:2365)+3000;
x3(3611:3665)=x3(3611:3665)-4000;
figure
plot(x3)
fids1= fopen('NoiseData.dat', 'wt');
fprintf(fids1, '%10.0f%10.0f', x3);
fclose(fids1);
toc