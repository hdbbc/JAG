function out=funclose(f,g)  %%  f���뺯����g�ṹ����
%% ������ �����ͺ�ʴ

%f����g������ f+g
N=length(f); 
M=length(g); 

fpg=zeros(size(f)); 
fg=zeros(size(g)); 

for i=1:N 
    for j=1:M 
       % if i-j>=0 
            if i-j>0             
                fg(j)=f(i-j)+g(j); 
            else 
                 fg(j)=g(j); 
              %  fg(j)=f(1)+g(j); 
            end 
       %  end 
    end 
    fpg(i)=max(fg); 
end %% fpg

%%%%%%%% fpg����g�ĸ�ʴ fpg-g

fmg=zeros(size(f)); 
fk=zeros(size(g));

for i=1:N 
    for j=1:M 
        if i+j<=N 
            fk(j)=fpg(i+j)-g(j); 
        end 
    end 
    fmg(i)=min(fk); 
end %% fmg %%%

out=fmg;
