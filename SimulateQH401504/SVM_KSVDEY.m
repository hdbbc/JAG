%% 清空环境变量
 tic
 clear;
 close all;
 clc;
    MTOriginal=load('QH401504TS5EY.dat');
    RawMT=load('QH401504TS5EYSynData.dat'); 
    RawMT=RawMT(300001:750000);
    average=sum(RawMT)/length(RawMT);
    RawMT=RawMT-average;
    fs=15;
    N=150;
    Length=length(RawMT);
    k=3000;
    fs=15;
    t=0:1/fs:(Length-1)/fs;
    
%      %% SVM处理
%      x=RawMT;
%      data0=yuzhices(x,N,k);%%测试集
%      data00=xlsread('E1.xlsx','B1:M3001');%%训练集
%      wine=data00(:,1:4);
%      wine_labels=data00(:,5);
%      classnumber=2;
% %% 清空环境变量
%      format compact;
% %% 数据提取
% % 选定训练集和测试集
% % 将第一类的1-30,第二类的60-95,第三类的131-153做为训练集
%      train_wine=[wine(1:3000,:)];
% % 相应的训练集的标签也要分离出来
%      train_wine_labels=[wine_labels(1:3000);];
% % 将第一类的31-59,第二类的96-130,第三类的154-178做为测试集
%      test_wine=[data0(1:k,1:4)];
% % 相应的测试集的标签也要分离出来
%      test_wine_labels=[wine_labels(1:k)];
% %% 数据预处理
% % 数据预处理,将训练集和测试集归一化到[0,1]区间
%      [mtrain,ntrain]=size(train_wine);
%      [mtest,ntest]=size(test_wine);
%      dataset=[train_wine;test_wine];
% % mapminmax为MATLAB自带的归一化函数
%      [dataset_scale,ps]=mapminmax(dataset',0,1);
%      dataset_scale=dataset_scale';
%      train_wine=dataset_scale(1:mtrain,:);
%      test_wine=dataset_scale((mtrain+1):(mtrain+mtest),:);
% %% SVM网络训练
%      model=svmtrain(train_wine_labels,train_wine, '-c 2 -g 1');
% %% SVM网络预测
%      [predict_label,accuracy]=svmpredict(test_wine_labels,test_wine,model);
%      datao=[data0(1:k,1:2),predict_label];
% %% 结果分析
% % 测试集的实际分类和预测分类图
%    figure(2)
%      hold on;
%      plot(test_wine_labels,'o');
%      plot(predict_label,'r*');
%      xlabel('测试集样本','FontSize',12);
%      ylabel('类别标签','FontSize',12);
%      legend('实际测试集分类','预测测试集分类');
%      title('测试集的实际分类和预测分类图','FontSize',12);
%      grid on;
% %%高质量信号与噪声信号
%    figure(3)
%      for i=1:k
%        P(i,:)=x(N*(i-1)+1:N*i);
%        if(datao(i,3:3)==1)%% 强干扰
%           plot((N*(i-1)+1:N*i),P(i,:),'r');axis([0 Length -max(x) max(x)]);
%           set(gca,'FontName','Times New Roman','FontSize',10);xlabel('Time(s)');ylabel('Amplitude');
%        else
%           plot((N*(i-1)+1:N*i),P(i,:),'b');axis([0 Length -max(x) max(x)]);
%           set(gca,'FontName','Times New Roman','FontSize',10);xlabel('Time(s)');ylabel('Amplitude');
%        hold on
%        end
%      end
%    figure(4)
%      subplot(311);
%      plot(t,x);legend('Noisy');
%      set(gca,'FontName','Times New Roman','FontSize',10);xlabel('Time(s)');ylabel('Amplitude');
%      a=zeros(1,450000);
%      b=zeros(1,450000);
%      for i=1:k
%        P(i,:)=x(N*(i-1)+1:N*i);
%        if(datao(i,3:3)==1) 
%          a(N*(i-1)+1:N*i)=P(i,:);
%          subplot(312);
%          plot((N*(i-1)+1:N*i),P(i,:),'r');axis([ 0 length(x) -max(x) max(x)]);legend('SVM-Noisy');
%          set(gca,'FontName','Times New Roman','FontSize',10);xlabel('Time(s)');ylabel('Amplitude');
%          hold on;
%        else
%          b(N*(i-1)+1:N*i)=P(i,:);
%          subplot(313); 
%          plot((N*(i-1)+1:N*i),P(i,:),'g');axis([ 0 length(x) -max(x) max(x)]);legend('SVM-Good');
%          set(gca,'FontName','Times New Roman','FontSize',10);xlabel('Time(s)');ylabel('Amplitude');
%          hold on
%        end
%      end
%      fids1 = fopen('QH401504TS5EYSVMGood.dat', 'wt');%保存KSVD处理后的噪声的信号
%      fprintf(fids1, '%10.0f%10.0f',b);
%      fclose(fids1);
%      CLzong=load('QH401504TS5EYSVMGood.dat');
%      fids2 = fopen('QH401504TS5EYSVMNoisy.dat', 'wt');%保存KSVD处理后的噪声的信号
%      fprintf(fids2, '%10.0f%10.0f',a);
%      fclose(fids2);
%      CLzong=load('QH401504TS5EYSVMNoisy.dat');
%% KSVD字典学习去噪
    a=load('QH401504TS5EYSVMNoisy.dat');
    b=load('QH401504TS5EYSVMGood.dat');
    N=length(a);
    for Step=0:00;
      Dataspan=1:N;
      x1=a;
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
      a=OMPerr(Dictionary,Data ,500); %2 %4 %3
      y=Dictionary*a;
      A=col2imstep(y,size(x1),[1,9],[1,1]);% 90  106 120
      Y=countcover(size(x1),[1,9],[1,1]);% 90  106 120
      dnoise=A./Y;
      mse1=sqrt(sum((x1-dnoise).^2)/N)
%%  数据输出
    figure(5)
      subplot(311);
      plot(t,x1,'b');
      set(gca,'FontName','Times New Roman','FontSize',10);xlabel('Time(s)');ylabel('Amplitude');legend('SVM-Noisy');
      subplot(312);plot(t,dnoise,'r');
      legend('提取出的噪声轮廓');ylabel('Amplitude');title('(b)'); 
      set(gca,'FontName','Times New Roman','FontSize',10);xlabel('Time(s)');ylabel('Amplitude');legend('contour');
      subplot(3,1,3);plot(t,x1-dnoise,'k');
      legend('有用的高频电磁信号');xlabel('Samples');ylabel('Amplitude');title('(c)');
    figure(6)
      plot(t,x1,'b');hold on;%噪声信号
      set(gca,'FontName','Times New Roman','FontSize',10);xlabel('Time(s)');ylabel('Amplitude');legend('SVM-Noisy');
      plot(t,dnoise,'r');hold on;%噪声轮廓
      set(gca,'FontName','Times New Roman','FontSize',10);xlabel('Time(s)');ylabel('Amplitude');legend('contour');
      Mtdata=x1-dnoise;
      SVMNoisy(Dataspan)=Mtdata;%% 处理后用残差替换原始数据
    end
%% 保存数据
    SVMKSVD=Mtdata+b+average;
    MT=load('QH401504TS5EY.dat');
    MT(300001:750000)=SVMKSVD;
    SVMKSVD=MT;
    fids4=fopen('QH401504TS5EYSVMKSVD.dat', 'wt');%保存SVM-KSVD处理后的信号
    fprintf(fids4,'%10.0f%10.0f',SVMKSVD);
    fclose(fids4);
    CLzong=load('QH401504TS5EYSVMKSVD.dat');
 figure
    plot(MTOriginal,'b');hold on;
    plot(SVMKSVD,'r');hold on;
toc