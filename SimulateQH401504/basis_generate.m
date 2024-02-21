function [C_l,Xi_l,fai,a]=basis_generate(changdu,M,N)
d=length(changdu);
C_l=zeros(d,1); %储存每个基的长度
Xi_l=zeros(d,1); %储存每个系数的长度
for i=1:d
    C_l(i)=changdu(i);
    Xi_l(i)=M+1-changdu(i);
end
fai=zeros(M,d); %载入基，结构为cXd，长度c，总共有d个基
a=zeros(M,d,N); %载入系数，结构为MXdXN，长度M，总共有d组
for i=1:d
    fai(1:C_l(i),i)=randn(C_l(i),1);
    a(1:Xi_l(i),i,:)=randn(Xi_l(i),N);
    fai_1=fai(1:C_l(i),i);
    fai(1:C_l(i),i)=fai_1/norm(fai_1);    
end