function out=funopen(f,g)  %%  f�����뺯����g���ṹ����
%% ������ �ȸ�ʴ������

%f����g�ĸ�ʴ f-g
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

% fmg����g������ fmg+g
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
