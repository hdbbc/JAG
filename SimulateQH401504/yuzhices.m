function[ydata]=yuzhices(MT,N,k)%% 载入信号
aaa=1;
 for i=1:k;
    Dataspan=00000+N*(i-1)+1:00000+N*(i-1)+N;
    x1=MT(Dataspan);
    file_title={'分段','样本熵','模糊熵','近似熵','盒维数'};   % 创建标题
%%%均值、均方值、均方根值、方差和均方差%%%
%%均方值是（x1^2+x2^2+x3^2+……xn^2）/n,均方根值是均方值的开方，均方差就是标准差，是方差的开方。
xmean=mean(x1);
sk=skewness(x1);%偏斜度
ku=kurtosis(x1);%峭度
xmean=roundn(xmean,0);
zuidazhi=max(abs(x1));
junfangzhi=x1*x1'/N;
junfanggen=sqrt(junfangzhi);junfanggen=roundn(junfanggen,0);
fangcha=std(x1)^2;
fangcha=roundn(fangcha,0);
biaozhuncha=std(x1);biaozhuncha=roundn(biaozhuncha,0);
SampEnVal=SampEn(x1, 1, 0.1*biaozhuncha);
ApEnd=ApEn(2,0.2*biaozhuncha,x1,1);%近似熵
LZCd=LZC(x1); %LZ复杂度
JSS=Fuzzy_entropy_bbd(1,0.1*biaozhuncha,x1);
HWS=FractalDim(x1,N);
xmeanresult(aaa)=xmean;%% 均值
zuidazhiresult(aaa)=zuidazhi;%%最值
junfanggenresult(aaa)=junfanggen;
fangcharesult(aaa)=fangcha;
biaozhuncharesult(aaa)=biaozhuncha;
SampEnValr(aaa)=roundn(SampEnVal,-3);
JSSr(aaa)=roundn(JSS,-3);
HWSr(aaa)=roundn(HWS,-3);
ApEnresult(aaa)=ApEnd;%近似熵
LZCresult(aaa)=LZCd;%LZ复杂度
skresult(aaa)=sk; %偏斜度
kuresult(aaa)=ku; %峭度
aaa=aaa+1;
% ydata=[xmean,junfangzhi,junfanggen,fangcha,biaozhuncha]   % 将三个函数的数值合并在矩阵 ydata 中
 end
 ydata=[SampEnValr',JSSr',ApEnresult',HWSr'];
%  ydata=[zuidazhiresult',junfanggenresult',fangcharesult',biaozhuncharesult',SampEnValr',JSSr',ApEnresult',LZCresult',HWSr',skresult',kuresult'];
%  %% 全部保存在 raw 里, 再一次性写入 Excel 文件
%  raw=cell(aaa+1,12);        % 待写入的内容一共有 12*5, 创建一个 12*5 空单元数组
%  raw(1,:)=file_title;   % 将标题保存在 raw 的第一行
% raw(2:aaa,1)=num2cell(1:aaa-1);           % 保存时间t, 需要使用 num2cell 将数值矩阵转换成单元矩阵
% raw(2:k+1,2:12)=num2cell(ydata);   % 保存三个函数的数值, 需要使用 num2cell 将数值矩阵转换成单元矩阵
%  xlswrite('D012455ATS4EX1030.xlsx',raw)   % 一次性将待写入的内容, 全部写入 Excel 文件