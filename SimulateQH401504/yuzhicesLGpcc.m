function[ydata]=yuzhices(MT,N,k)%% 载入信号

T0=load('Noisy.dat');
T1=T0(N*0+1:N*1);T1=T1';
figure
plot(T1)
% file_title={'Order','Maximum','Sqrt','PCC','Std','SampEn','FuzzyEn','FractalDim'};   % 创建标题
% file_title={'Order','Maximum','Sqrt','PCC','Std'};   % 创建标题
aaa=1;
 for i=1:k;
    Dataspan=00000+N*(i-1)+1:00000+N*(i-1)+N;
    x0=MT(Dataspan);
%%%均值、均方值、均方根值、方差和均方差%%%
%%均方值是（x1^2+x2^2+x3^2+……xn^2）/n,均方根值是均方值的开方，均方差就是标准差，是方差的开方。
xmean=mean(x0);
xmean=roundn(xmean,-4);
zuidazhi=max(abs(x0));
junfangzhi=x0*x0'/N;
junfanggen=sqrt(junfangzhi);junfanggen=roundn(junfanggen,-4);
fangcha=std(x0)^2;
fangcha=roundn(fangcha,-4);
biaozhuncha=std(x0);biaozhuncha=roundn(biaozhuncha,-4);
% SampEnVal=SampEn(x0, 1, 0.1*biaozhuncha);
% JSS=Fuzzy_entropy_bbd(1,0.1*biaozhuncha,x0);
% HWS=FractalDim(x0,N);
% xmeanresult(aaa)=xmean;%% 均值
zuidazhiresult(aaa)=zuidazhi;%%最值
junfanggenresult(aaa)=junfanggen;
% fangcharesult(aaa)=fangcha;
biaozhuncharesult(aaa)=biaozhuncha;
fftT1=(abs(fft(T1))/N)*2;
fftR1=(abs(fft(x0))/N)*2;
PCC0=corrcoef(fftT1,fftR1);c=PCC0(1,2);PCC(aaa)=roundn(c,-4);
% SampEnValr(aaa)=roundn(SampEnVal,-4);
% JSSr(aaa)=roundn(JSS,-4);
% HWSr(aaa)=roundn(HWS,-4);
aaa=aaa+1;
% ydata=[xmean,junfangzhi,junfanggen,fangcha,biaozhuncha]   % 将三个函数的数值合并在矩阵 ydata 中
 end
%  ydata=[zuidazhiresult',junfanggenresult',PCC',biaozhuncharesult',SampEnValr',JSSr',HWSr'];
  ydata=[zuidazhiresult',junfanggenresult',PCC',biaozhuncharesult'];
%  %% 全部保存在 raw 里, 再一次性写入 Excel 文件
% raw=cell(aaa+1,8);        % 待写入的内容一共有 12*5, 创建一个 12*5 空单元数组
% raw(1,:)=file_title;   % 将标题保存在 raw 的第一行
% raw(2:aaa,1)=num2cell(1:aaa-1);           % 保存时间t, 需要使用 num2cell 将数值矩阵转换成单元矩阵
% raw(2:k+1,2:8)=num2cell(ydata);   % 保存三个函数的数值, 需要使用 num2cell 将数值矩阵转换成单元矩阵
% xlswrite('Raw_T(HDL1038-040)_(L1-38)_(D90-1)_F(7-3)_A1_C1_FFT_CEEMD.xlsx',raw)   % 一次性将待写入的内容, 全部写入 Excel 文件

