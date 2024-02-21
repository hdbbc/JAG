%% 载入信号
  clc; 
  clear; 
  close all;
  tic
    Original=load('QH401504TS5EX.dat');
    RawMT=load('QH401504TS5EXSynData.dat');
    RawMT=RawMT(300001:750000);
    average=sum(Original)/length(Original);
    Length=length(RawMT);
    RawMT=RawMT-average;
    fs=15;
    N=Length;
    t=0:1/fs:(Length-1)/fs;
    f=0:fs*1/Length:fs*(1-1/Length);
  for Step=0:00;
      Dataspan=1:N;
      x1=RawMT;
%% KSVD电磁去噪
      origSignal=x1;
      signal_2=(sum(origSignal(:).^2));
      Data=im2colstep(x1,[1,9],[1,1]);
      rperm=randperm(size(Data,2));
      patchData=Data(:,rperm(1:900));
      param.L=100;   % number of elements in each linear combination.
      param.displayProgress=1;  
      param.InitializationMethod='DataElements';
      param.errorFlag=1; % decompose signals until a certain error is reached. do not use fix number of coefficients.
      param.errorGoal=0; 
      param.preserveDCAtom=1;
      param.numIteration=1; % number of iteration to EXecute the K-SVD algorithm.
      param.K=900;  % number of dictionary elements
      [Dictionary,output]=KSVD(patchData,param);
      a=OMPerr(Dictionary,Data ,200); %2 %4 %3
      y=Dictionary*a;
      A=col2imstep(y,size(x1),[1,9],[1,1]);% 90  106 120
      Y=countcover(size(x1),[1,9],[1,1]);% 90  106 120
      dnoise=A./Y;
      mse1=sqrt(sum((x1-dnoise).^2)/N)
%%  数据输出
    figure
      subplot(311);
      plot(t,x1,'b');
      set(gca,'FontName','Times New Roman','FontSize',10);xlabel('Time(s)');ylabel('Amplitude');legend('Noisy');
      subplot(312);plot(t,dnoise,'r');
      legend('提取出的噪声轮廓');ylabel('Amplitude');title('(b)'); 
      set(gca,'FontName','Times New Roman','FontSize',10);xlabel('Time(s)');ylabel('Amplitude');legend('contour');
      subplot(3,1,3);plot(t,x1-dnoise,'k');
      legend('有用的高频电磁信号');xlabel('Samples');ylabel('Amplitude');title('(c)');
    figure
      plot(t,x1,'b');hold on;%噪声信号
      set(gca,'FontName','Times New Roman','FontSize',10);xlabel('Time(s)');ylabel('Amplitude');legend('SVM-Noisy');
      plot(t,dnoise,'r');hold on;%噪声轮廓
      set(gca,'FontName','Times New Roman','FontSize',10);xlabel('Time(s)');ylabel('Amplitude');legend('contour');
      Mtdata=x1-dnoise;  
  end
   %% 数据替换
      MTKSVD=Mtdata+average;
      Original(300001:750000)=MTKSVD;
      MTKSVD=Original;
      fids1=fopen('QH401504TS5EXKSVD.dat', 'wt');%去噪后的高频信号
      fprintf(fids1,'%10.0f%10.0f',MTKSVD);
      fclose(fids1);
      Check=load('QH401504TS5EXKSVD.dat');
%%
      Nosiefree=load('QH401504TS5EX.dat');
   figure
      plot(Nosiefree,'b');hold on;%噪声信号
      set(gca,'FontName','Times New Roman','FontSize',10);xlabel('Time(s)');ylabel('Amplitude');legend('SVM-Noisy');
      plot(MTKSVD,'r');hold on;%噪声轮廓
      set(gca,'FontName','Times New Roman','FontSize',10);xlabel('Time(s)');ylabel('Amplitude');legend('contour');
      toc
   
 
