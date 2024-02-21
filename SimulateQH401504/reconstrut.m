function re_S=reconstrut(fai,a,C_l,Xi_l,range)       
re_S=zeros(size(a,1),size(a,3));
for ii=1:size(a,3)
    for j=range
        dd=conv(fai(1:C_l(j),j),a(1:Xi_l(j),j,ii));
        re_S(:,ii)=dd+re_S(:,ii);
    end
end