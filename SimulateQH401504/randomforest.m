function randomforest()
clc
clear all
T=1;%bagging�����Ĵ���
M =xlsread('qhjz2.xlsx','C2:C201'); % ֱ�Ӵ洢��data������
% M = importdata('D:\��ҵ���\���ݼ�1\australian.txt');  %��ȡ����
[sm,sn]=size(M);
% for i=1:sm             %��һ��
%     mins=min(M(i,1:sn-1));
%     maxs=max(M(i,1:sn-1));
%     for j=1:sn-1
%         M(i,j)=2*(M(i,j)-mins)/(maxs-mins)-1;
%     end
% end
indices=crossvalind('Kfold',M(1:sm,sn),10); %ʮ�۽��棬����ѵ�����Ͳ��Լ�
testindices=(indices==1); %���Լ�����
trainindices=~testindices;%ѵ��������
trainset=M(trainindices,:); %��ȡѵ����
testset=M(testindices,:);%��ȡ���Լ�
[testm,~]=size(testset);
[trainm,trainn]=size(trainset);

predict=zeros(trainm,T);
for t=1:T %��ʼbagging����
    D=[];%ѵ����
    for i=1:trainm%����
        k=randperm(trainm,1);
        D=[D;trainset(k,:)];
    end
    [~,sn]=size(D);
    a=ones(sn-1,1);%���Լ���a��1���������δ������
  
    tree=maketree(D,a);%�ݹ鹹��򵥾�����
    
    for i=1:trainm
        treet=tree;
        while 1
           
            if treet.isnode==0
                predict(i,T)=treet.a;
                break;
            end
            if trainset(i,treet.mark)<=treet.a
                treet=treet.child(1);
            else
                treet=treet.child(2);
            end
          
        end
    end
    
end
acc=0;
for i=1:trainm
    if trainset(i,end)==mode(predict(i,:))
        acc=acc+1;
    end
end
acc=acc/trainm
end
