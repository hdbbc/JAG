 tic
    clc; clear; close all;
    x1=load('QH401504TS5EY.dat');
    x2=load('QH401504TS5EYSynData.dat');
    x3=load('QH401504TS5EYMMF.dat');
    x4=load('QH401504TS5EYKSVD.dat');
    x5=load('QH401504TS5EYSVMKSVD.dat');
    x6=load('QH401504TS5EYMMFWaveletRuan.dat');
    x7=load('QH401504TS5EYMMFWaveletYing.dat');
    x8=load('QH401504TS5EYMMFKSVD.dat');
    x9=load('QH401504TS5EYMMFSVMKSVD.dat');
    
    x1=x1(300001:1000000);
    x2=x2(300001:1000000);
    x3=x3(300001:1000000);
    x4=x4(300001:1000000);
    x5=x5(300001:1000000);
    x6=x6(300001:1000000);
    x7=x7(300001:1000000);
    x8=x8(300001:1000000);
    x9=x9(300001:1000000);
    average=sum(x1)/length(x1);
    x1=x1-average;
    x2=x2-average;
    x3=x3-average;
    x4=x4-average;
    x5=x5-average;
    x6=x6-average;
    x7=x7-average;
    x8=x8-average;
    x9=x9-average;

%% ²ÎÊý¼ÆËã
    snr2=20*log10(norm(x1)/norm(x1-x2));
    ncc2=sum(x1.*x2)/sqrt((sum(x1.*x1)*(sum(x2.*x2))));
    E2=norm(x1-x2)/norm(x1); 
    snr3=20*log10(norm(x1)/norm(x1-x3));
    ncc3=sum(x1.*x3)/sqrt((sum(x1.*x1)*(sum(x3.*x3))));
    E3=norm(x1-x3)/norm(x1);
    snr4=20*log10(norm(x4)/norm(x1-x4));
    ncc4=sum(x1.*x4)/sqrt((sum(x1.*x1)*(sum(x4.*x4))));
    E4=norm(x1-x4)/norm(x1); 
    snr5=20*log10(norm(x5)/norm(x1-x5));
    ncc5=sum(x1.*x5)/sqrt((sum(x1.*x1)*(sum(x5.*x5))));
    E5=norm(x1-x5)/norm(x1); 
    snr6=20*log10(norm(x6)/norm(x1-x6));
    ncc6=sum(x1.*x6)/sqrt((sum(x1.*x1)*(sum(x6.*x6))));
    E6=norm(x1-x6)/norm(x1); 
    snr7=20*log10(norm(x7)/norm(x1-x7));
    ncc7=sum(x1.*x7)/sqrt((sum(x1.*x1)*(sum(x7.*x7))));
    E7=norm(x1-x7)/norm(x1); 
    snr8=20*log10(norm(x8)/norm(x1-x8));
    ncc8=sum(x1.*x8)/sqrt((sum(x1.*x1)*(sum(x8.*x8))));
    E8=norm(x1-x9)/norm(x1); 
    snr9=20*log10(norm(x9)/norm(x1-x9));
    ncc9=sum(x1.*x9)/sqrt((sum(x1.*x1)*(sum(x9.*x9))));
    E9=norm(x1-x9)/norm(x1); 
  
    toc
   
