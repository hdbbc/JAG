function [C_l,Xi_l,fai,a]=basis_generate(changdu,M,N)
d=length(changdu);
C_l=zeros(d,1); %����ÿ�����ĳ���
Xi_l=zeros(d,1); %����ÿ��ϵ���ĳ���
for i=1:d
    C_l(i)=changdu(i);
    Xi_l(i)=M+1-changdu(i);
end
fai=zeros(M,d); %��������ṹΪcXd������c���ܹ���d����
a=zeros(M,d,N); %����ϵ�����ṹΪMXdXN������M���ܹ���d��
for i=1:d
    fai(1:C_l(i),i)=randn(C_l(i),1);
    a(1:Xi_l(i),i,:)=randn(Xi_l(i),N);
    fai_1=fai(1:C_l(i),i);
    fai(1:C_l(i),i)=fai_1/norm(fai_1);    
end