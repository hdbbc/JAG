function[ydata]=yuzhices(MT,N,k)%% �����ź�
aaa=1;
 for i=1:k;
    Dataspan=00000+N*(i-1)+1:00000+N*(i-1)+N;
    x1=MT(Dataspan);
    file_title={'�ֶ�','������','ģ����','������','��ά��'};   % ��������
%%%��ֵ������ֵ��������ֵ������;�����%%%
%%����ֵ�ǣ�x1^2+x2^2+x3^2+����xn^2��/n,������ֵ�Ǿ���ֵ�Ŀ�������������Ǳ�׼��Ƿ���Ŀ�����
xmean=mean(x1);
sk=skewness(x1);%ƫб��
ku=kurtosis(x1);%�Ͷ�
xmean=roundn(xmean,0);
zuidazhi=max(abs(x1));
junfangzhi=x1*x1'/N;
junfanggen=sqrt(junfangzhi);junfanggen=roundn(junfanggen,0);
fangcha=std(x1)^2;
fangcha=roundn(fangcha,0);
biaozhuncha=std(x1);biaozhuncha=roundn(biaozhuncha,0);
SampEnVal=SampEn(x1, 1, 0.1*biaozhuncha);
ApEnd=ApEn(2,0.2*biaozhuncha,x1,1);%������
LZCd=LZC(x1); %LZ���Ӷ�
JSS=Fuzzy_entropy_bbd(1,0.1*biaozhuncha,x1);
HWS=FractalDim(x1,N);
xmeanresult(aaa)=xmean;%% ��ֵ
zuidazhiresult(aaa)=zuidazhi;%%��ֵ
junfanggenresult(aaa)=junfanggen;
fangcharesult(aaa)=fangcha;
biaozhuncharesult(aaa)=biaozhuncha;
SampEnValr(aaa)=roundn(SampEnVal,-3);
JSSr(aaa)=roundn(JSS,-3);
HWSr(aaa)=roundn(HWS,-3);
ApEnresult(aaa)=ApEnd;%������
LZCresult(aaa)=LZCd;%LZ���Ӷ�
skresult(aaa)=sk; %ƫб��
kuresult(aaa)=ku; %�Ͷ�
aaa=aaa+1;
% ydata=[xmean,junfangzhi,junfanggen,fangcha,biaozhuncha]   % ��������������ֵ�ϲ��ھ��� ydata ��
 end
 ydata=[SampEnValr',JSSr',ApEnresult',HWSr'];
%  ydata=[zuidazhiresult',junfanggenresult',fangcharesult',biaozhuncharesult',SampEnValr',JSSr',ApEnresult',LZCresult',HWSr',skresult',kuresult'];
%  %% ȫ�������� raw ��, ��һ����д�� Excel �ļ�
%  raw=cell(aaa+1,12);        % ��д�������һ���� 12*5, ����һ�� 12*5 �յ�Ԫ����
%  raw(1,:)=file_title;   % �����Ᵽ���� raw �ĵ�һ��
% raw(2:aaa,1)=num2cell(1:aaa-1);           % ����ʱ��t, ��Ҫʹ�� num2cell ����ֵ����ת���ɵ�Ԫ����
% raw(2:k+1,2:12)=num2cell(ydata);   % ����������������ֵ, ��Ҫʹ�� num2cell ����ֵ����ת���ɵ�Ԫ����
%  xlswrite('D012455ATS4EX1030.xlsx',raw)   % һ���Խ���д�������, ȫ��д�� Excel �ļ�