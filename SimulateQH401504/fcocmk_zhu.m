function f3=fcocmk_zhu(f,m,k)  %% ��ѧ��̬���˲���mΪ�ṹԪ�صĵ�����kΪ��״����Ҫ�Ƕ���Բ�Σ�
% k=min(abs(diff(f))); %%�������Ӧѡ��ṹԪ�ظ߶ȵĻ�


  for i=1:m %����ṹԪ��
    %g(i)=(m^2-(i-1)^2)*k;%%1/4ԲĬ��
    %g(i)=500*(m-(i-1))*k;%%%%%б��
    %g(i)=100*m*k;%ֱ��
    g(i)=0;
    %g=k/4*[1,2,3,4,3,2,1];%%%%%ֱ��ָ��������
  end;%%�ṹԪ�ض������

f3=(fco(f,g)+foc(f,g))/2;%%��-�պͱ�-�������̬�˲���  

function f3=foc(f,g) %��-���˲���
f3=kbg(kfg(f,g),g); %�ȿ�����������

function f3=fco(f,g) %��-���˲���
f3=kfg(kbg(f,g),g); %�ȱ����������

function f3=kfg(f,g)  %������ 
f3=slpp(slpf(f,g),g);%�ȸ�ʴ������

function f3=kbg(f,g)  %������
f3=slpf(slpp(f,g),g);% �����ͺ�ʴ


function ms=slpf(f,g)  %%��ʴ����
n=length(f);
m=length(g);
  for i=1:n-m-1 %��1��n-m-1�㴦��
      
    for j=1:m
      msi(j)=f(i+j-1)-g(j);
    end
  ms(i)=min(msi);
  end;
  for i=n-m:n %�����m�㴦�����ڱ�Ե����
    for j=1:n-i
      msi(j)=f(i+j-1)-g(j);
    end
      ms(i)=min(msi);
  end;%��ʴ�������

function ms=slpp(f,g) %���Ͳ���
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
  end;%���Ͳ������




