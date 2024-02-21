function f3=fcocmk_zhu(f,m,k)  %% 数学形态法滤波，m为结构元素的点数，k为形状（主要是对于圆形）
% k=min(abs(diff(f))); %%如果自适应选择结构元素高度的话


  for i=1:m %定义结构元素
    %g(i)=(m^2-(i-1)^2)*k;%%1/4圆默认
    %g(i)=500*(m-(i-1))*k;%%%%%斜线
    %g(i)=100*m*k;%直线
    g(i)=0;
    %g=k/4*[1,2,3,4,3,2,1];%%%%%直接指定三角形
  end;%%结构元素定义结束

f3=(fco(f,g)+foc(f,g))/2;%%开-闭和闭-开组合形态滤波器  

function f3=foc(f,g) %开-闭滤波器
f3=kbg(kfg(f,g),g); %先开运算后闭运算

function f3=fco(f,g) %闭-开滤波器
f3=kfg(kbg(f,g),g); %先闭运算后开运算

function f3=kfg(f,g)  %开运算 
f3=slpp(slpf(f,g),g);%先腐蚀后膨胀

function f3=kbg(f,g)  %闭运算
f3=slpf(slpp(f,g),g);% 先膨胀后腐蚀


function ms=slpf(f,g)  %%腐蚀操作
n=length(f);
m=length(g);
  for i=1:n-m-1 %对1到n-m-1点处理
      
    for j=1:m
      msi(j)=f(i+j-1)-g(j);
    end
  ms(i)=min(msi);
  end;
  for i=n-m:n %对最后m点处理（由于边缘）。
    for j=1:n-i
      msi(j)=f(i+j-1)-g(j);
    end
      ms(i)=min(msi);
  end;%腐蚀操作完毕

function ms=slpp(f,g) %膨胀操作
n=length(f);
m=length(g);
  for i=1:m
    for j=1:i
      msi(j)=f(i-j+1)+g(j);
    end
    ms(i)=max(msi);
  end;
  for i=m+1:n
    for j=1:m
      msi(j)=f(i-j+1)+g(j);
    end
    ms(i)=max(msi);
  end;%膨胀操作完毕




