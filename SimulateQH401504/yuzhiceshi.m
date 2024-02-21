%% �����ź�
tic
clear all;
close all;
clc;
MT=load('test-Noisy.dat');
% average=sum(MT)/length(MT) 
% MT=MT-average;                %%��һ�δ���ʱȥ������
figure(1)
   plot(MT)
N=1200;
fs=150;

file_title={'�ֶ�','��ֵ','���ֵ','������ֵ','����','��׼��','������','ģ����','��ά��'};   % ��������
aaa=1;
k=48
 for i=1:k;
    Dataspan=000+N*(i-1)+1:000+N*(i-1)+N;
    x1=MT(Dataspan);
    figure(22)
    plot(x1)
%%%��ֵ������ֵ��������ֵ������;�����%%%
%%����ֵ�ǣ�x1^2+x2^2+x3^2+����xn^2��/n,������ֵ�Ǿ���ֵ�Ŀ�������������Ǳ�׼��Ƿ���Ŀ�����
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
% ydata=[xmean,junfangzhi,junfanggen,fangcha,biaozhuncha]   % ��������������ֵ�ϲ��ھ��� ydata ��
 end
 ydata=[xmeanresult',zuidazhiresult',junfanggenresult',fangcharesult',biaozhuncharesult',SampEnValr',JSSr',HWSr'];
 %% ȫ�������� raw ��, ��һ����д�� Excel �ļ�
raw=cell(aaa+1,9);        % ��д�������һ���� 12*5, ����һ�� 12*5 �յ�Ԫ����
raw(1,:)=file_title;   % �����Ᵽ���� raw �ĵ�һ��
raw(2:aaa,1)=num2cell(1:aaa-1);           % ����ʱ��t, ��Ҫʹ�� num2cell ����ֵ����ת���ɵ�Ԫ����
raw(2:k+1,2:9)=num2cell(ydata);   % ����������������ֵ, ��Ҫʹ�� num2cell ����ֵ����ת���ɵ�Ԫ����
xlswrite('testyuzhiceshi1.xlsx',raw)   % һ���Խ���д�������, ȫ��д�� Excel �ļ�
 figure(2)
%  plot(junfanggenresult)
 subplot(311);plot(SampEnValr);
 subplot(312);plot(JSSr);
 subplot(313);plot(HWSr);