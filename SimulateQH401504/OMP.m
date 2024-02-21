function [A]=OMP(D,X,L); 
%=============================================
% Sparse coding of a group of signals based on a given 
% dictionary and specified number of atoms to use. 
% input arguments: 
%       D - the dictionary (its columns MUST be normalized).
%       X - the signals to represent
%       L - the max. number of coefficients for each signal.
% output arguments: 
%       A - sparse coefficient matrix.
%=============================================
[n,P]=size(X);
[n,K]=size(D);
for k=1:1:P,  %从第一个信号到最后一个信号
    a=[];
    x=X(:,k); %第k个信号
    residual=x;  %初始化残余
    indx=zeros(L,1);  %初始化原子，这里L表示一个信号最多可以由L个原子所构成
    for j=1:1:L,
        proj=D'*residual;   %所有的基与信号的内积
        [maxVal,pos]=max(abs(proj));   %pos为内积最大的基的位置，即序号
        pos=pos(1);
        indx(j)=pos;
        a=pinv(D(:,indx(1:j)))*x;
        residual=x-D(:,indx(1:j))*a;
        if sum(residual.^2) < 1e-6
            break;
        end
    end;
    temp=zeros(K,1);
    temp(indx(1:j))=a;
    A(:,k)=sparse(temp);
end;
return;
