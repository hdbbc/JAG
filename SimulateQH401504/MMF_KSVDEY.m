clc; 
    clear; 
    close all;
    tic
    OriginalMT=load('QH401504TS5EY.dat');
    RawMT=load('QH401504TS5EYSynData.dat');
    average=sum(RawMT)/length(RawMT);
    RawMT=RawMT-average;
    Length=length(RawMT);
    fs=15;
    N=Length;
    t=0:1/fs:(Length-1)/fs;
    f=0:fs*1/Length:fs*(1-1/Length);
%% MMF
    MT_MMF=fcocmk_zhu(RawMT,70,0);
    High=RawMT-MT_MMF;
    figure(1)
    hold on
    plot(t,RawMT,'k'); 
    plot(t,MT_MMF,'r');
    set(gca,'FontName','Times New Roman','FontSize',10);xlabel('Time(s)');ylabel('Amplitude');
    %% ����MMF�����ĵ�Ƶ��Ч�ź����Ƶ�ź�
    fids1=fopen('QH401504TS5EYMMF-Low.dat','wt');%�����Ƶ�ź�
    fprintf(fids1, '%10.0f%10.0f',MT_MMF);
    fclose(fids1);
    Low_Check=load('QH401504TS5EYMMF-Low.dat');  
    fids2=fopen('QH401504TS5EYMMF-High.dat', 'wt');%�����Ƶ�ź�
    fprintf(fids2, '%10.0f%10.0f',High);
    fclose(fids2);
    High_Check=load('QH401504TS5EYMMF-High.dat');   
%% KSVD�ֵ�ѧϰȥ��
    for Step=0:00;
      Dataspan=1:N;
      x1=High;
%% KSVD���ȥ��
      origSignal=x1;
      signal_2=(sum(origSignal(:).^2));
      Data=im2colstep(x1,[1,5],[1,1]);
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
      a=OMPerr(Dictionary,Data ,300); %2 %4 %3
      y=Dictionary*a;
      A=col2imstep(y,size(x1),[1,5],[1,1]);% 90  106 120
      Y=countcover(size(x1),[1,5],[1,1]);% 90  106 120
      dnoise=A./Y;
      mse1=sqrt(sum((x1-dnoise).^2)/N)
%%  �������
    figure(2)
      subplot(311);
      plot(t,x1,'b');
      set(gca,'FontName','Times New Roman','FontSize',10);xlabel('Time(s)');ylabel('Amplitude');legend('Noisy');
      subplot(312);plot(t,dnoise,'r');
      legend('��ȡ������������');ylabel('Amplitude');title('(b)'); 
      set(gca,'FontName','Times New Roman','FontSize',10);xlabel('Time(s)');ylabel('Amplitude');legend('contour');
      subplot(3,1,3);plot(t,x1-dnoise,'k');
      legend('���õĸ�Ƶ����ź�');xlabel('Samples');ylabel('Amplitude');title('(c)');
    figure(3)
      plot(t,x1,'b');hold on;%�����ź�
      set(gca,'FontName','Times New Roman','FontSize',10);xlabel('Time(s)');ylabel('Amplitude');legend('SVM-Noisy');
      plot(t,dnoise,'r');hold on;%��������
      set(gca,'FontName','Times New Roman','FontSize',10);xlabel('Time(s)');ylabel('Amplitude');legend('contour');
      Mtdata=x1-dnoise;
      fids1=fopen('QH401504TS5EYMMF-High-KSVD.dat', 'wt');%ȥ���ĸ�Ƶ�ź�
      fprintf(fids1,'%10.0f%10.0f',Mtdata);
      fclose(fids1);
    end
%% MMF�ĵ�Ƶ�ź���KSVD�����ĸ�Ƶ�ź�ƴ��
    Low=load('QH401504TS5EYMMF-Low.dat');
    High=load('QH401504TS5EYMMF-High-KSVD.dat');
    MMFKSVD=Low+High+average;
%% ��������
    fids1=fopen('QH401504TS5EYMMFKSVD.dat', 'wt');
    fprintf(fids1,'%10.0f%10.0f',MMFKSVD);
    fclose(fids1);
    Check=load('QH401504TS5EYMMFKSVD.dat');
    figure(4)
    plot(t,OriginalMT,'b');hold on;
    set(gca,'FontName','Times New Roman','FontSize',10);xlabel('Time(s)');ylabel('Amplitude');legend('Original');
    plot(t,MMFKSVD,'r');hold on;
    set(gca,'FontName','Times New Roman','FontSize',10);xlabel('Time(s)');ylabel('Amplitude');legend('MMFKSVD');
 toc
 