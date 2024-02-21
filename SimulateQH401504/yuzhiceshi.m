%% 载入信号
tic
clear all;
close all;
clc;
MT=load('test-Noisy.dat');
% average=sum(MT)/length(MT) 
% MT=MT-average;                %%第一次处理时去除基线
figure(1)
   plot(MT)
N=1200;
fs=150;

file_title={'分段','均值','最大值','均方根值','方差','标准差','样本熵','模糊熵','盒维数'};   % 创建标题
aaa=1;
k=48
 for i=1:k;
    Dataspan=000+N*(i-1)+1:000+N*(i-1)+N;
    x1=MT(Dataspan);
    figure(22)
    plot(x1)
%%%均值、均方值、均方根值、方差和均方差%%%
%%均方值是（x1^2+x2^2+x3^2+……xn^2）/n,均方根值是均方值的开方，均方差就是标准差，是方差的开方。
xmean=mean(x1);xmean=roundn(xmean,-3);
zuidazhi=max(abs(x1));
junfangzhi=x1*x1'/N;
junfanggen=sqrt(junfangzhi);junfanggen=roundn(junfanggen,0);
fangcha=std(x1)^2;
fangcha=roundn(fangcha,0);
biaozhuncha=std(x1);biaozhuncha=roundn(biaozhuncha,-3);
SampEnVal=SampEn(x1, 1, 0.1*biaozhuncha);
JSS=Fuzzy_entropy_bbd(1,0.1*biaozhuncha,x1);
HWS=FractalDim(x1,N);
xmeanresult(aaa)=xmean;
zuidazhiresult(aaa)=zuidazhi;
junfanggenresult(aaa)=junfanggen;
fangcharesult(aaa)=fangcha;
biaozhuncharesult(aaa)=biaozhuncha;
SampEnValr(aaa)=SampEnVal
JSSr(aaa)=JSS
HWSr(aaa)=HWS
aaa=aaa+1;
% ydata=[xmean,junfangzhi,junfanggen,fangcha,biaozhuncha]   % 将三个函数的数值合并在矩阵 ydata 中
 end
 ydata=[xmeanresult',zuidazhiresult',junfanggenresult',fangcharesult',biaozhuncharesult',SampEnValr',JSSr',HWSr'];
 %% 全部保存在 raw 里, 再一次性写入 Excel 文件
raw=cell(aaa+1,9);        % 待写入的内容一共有 12*5, 创建一个 12*5 空单元数组
raw(1,:)=file_title;   % 将标题保存在 raw 的第一行
raw(2:aaa,1)=num2cell(1:aaa-1);           % 保存时间t, 需要使用 num2cell 将数值矩阵转换成单元矩阵
raw(2:k+1,2:9)=num2cell(ydata);   % 保存三个函数的数值, 需要使用 num2cell 将数值矩阵转换成单元矩阵
xlswrite('testyuzhiceshi1.xlsx',raw)   % 一次性将待写入的内容, 全部写入 Excel 文件
 figure(2)
%  plot(junfanggenresult)
 subplot(311);plot(SampEnValr);
 subplot(312);plot(JSSr);
 subplot(313);plot(HWSr);