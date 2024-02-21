function out=funopen(f,g)  %%  f：输入函数；g：结构函数
%% 开运算 先腐蚀后膨胀

%f关于g的腐蚀 f-g
N=length(f); 
M=length(g); 

fmg=zeros(size(f)); 
fg=zeros(size(g)); 

for i=1:N 
    for j=1:M 
          if i+j<=N            
            fg(j)=f(i+j)-g(j); 
          end 
    end 
    fmg(i)=min(fg); 
end %%% fmg

% fmg关于g的膨胀 fmg+g
fpg=zeros(size(f)); 
fk=zeros(size(g)); 
for i=1:N 
    for j=1:M 
        % if i-j>=0 
            if i-j>0            
             fk(j)=fmg(i-j)+g(j); 
            else 
               % fk(j)=fmg(1)+g(j); 
                fk(j)=g(j); 
            %end              
        end 
    end 
    fpg(i)=max(fk); 
end %%%%%%  fpg %%%

out=fpg;
