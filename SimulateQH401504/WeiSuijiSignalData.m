 tic 
x=zeros(1,2048);
x(201:260)=x(201:260)+1;
x(421:470)=x(421:470)-0.8;
x(701:750)=x(701:750)+0.9;
x(1211:1270)=x(1211:1270)-0.75;
x(1521:1560)=x(1521:1560)+0.85;
x(1851:1890)=x(1851:1890)-1;
Y=x;
%     xlabel('采样点');yla+el('幅度');
    WeiSuiji=4000*Y;    
    figure(1)
    plot(WeiSuiji);set(gca,'FontName','Times New Roman','FontSize',9);
    fids1 = fopen('WeisuijiSignalData.dat', 'wt');%QH401504TS5EYCL1的1：16384个数据已处理
    fprintf(fids1, '%10.0f%10.0f', WeiSuiji);
    fclose(fids1);
toc

