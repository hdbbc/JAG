function out=funclose(f,g)  %%  f输入函数；g结构函数
%% 闭运算 先膨胀后腐蚀

%f关于g的膨胀 f+g
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

%%%%%%%% fpg关于g的腐蚀 fpg-g

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
