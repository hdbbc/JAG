function[ydata]=yuzhices(MT,N,k)%% �����ź�

T0=load('Noisy.dat');
T1=T0(N*0+1:N*1);T1=T1';
figure
plot(T1)
% file_title={'Order','Maximum','Sqrt','PCC','Std','SampEn','FuzzyEn','FractalDim'};   % ��������
% file_title={'Order','Maximum','Sqrt','PCC','Std'};   % ��������
aaa=1;
 for i=1:k;
    Dataspan=00000+N*(i-1)+1:00000+N*(i-1)+N;
    x0=MT(Dataspan);
%%%��ֵ������ֵ��������ֵ������;�����%%%
%%����ֵ�ǣ�x1^2+x2^2+x3^2+����xn^2��/n,������ֵ�Ǿ���ֵ�Ŀ�������������Ǳ�׼��Ƿ���Ŀ�����
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
% xmeanresult(aaa)=xmean;%% ��ֵ
zuidazhiresult(aaa)=zuidazhi;%%��ֵ
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
% ydata=[xmean,junfangzhi,junfanggen,fangcha,biaozhuncha]   % ��������������ֵ�ϲ��ھ��� ydata ��
 end
%  ydata=[zuidazhiresult',junfanggenresult',PCC',biaozhuncharesult',SampEnValr',JSSr',HWSr'];
  ydata=[zuidazhiresult',junfanggenresult',PCC',biaozhuncharesult'];
%  %% ȫ�������� raw ��, ��һ����д�� Excel �ļ�
% raw=cell(aaa+1,8);        % ��д�������һ���� 12*5, ����һ�� 12*5 �յ�Ԫ����
% raw(1,:)=file_title;   % �����Ᵽ���� raw �ĵ�һ��
% raw(2:aaa,1)=num2cell(1:aaa-1);           % ����ʱ��t, ��Ҫʹ�� num2cell ����ֵ����ת���ɵ�Ԫ����
% raw(2:k+1,2:8)=num2cell(ydata);   % ����������������ֵ, ��Ҫʹ�� num2cell ����ֵ����ת���ɵ�Ԫ����
% xlswrite('Raw_T(HDL1038-040)_(L1-38)_(D90-1)_F(7-3)_A1_C1_FFT_CEEMD.xlsx',raw)   % һ���Խ���д�������, ȫ��д�� Excel �ļ�

