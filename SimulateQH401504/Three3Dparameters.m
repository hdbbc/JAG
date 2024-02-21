%% 清空环境变量
clc
clear
close all
x1=xlsread('Good.xlsx','B2:L51');
x2=xlsread('canshu.xlsx','B2:L51');
x3=xlsread('canshu.xlsx','B52:L101');
x4=xlsread('canshu.xlsx','B102:L151');
x=[x1;x2;x3;x4];
y=1:200;
z1=ones(1,50);
z2=-1*ones(1,150);
z=[z1,z2];
figure
subplot(221)
plot3(y(1:50)',x1(:,5),z(1:50)','bo');hold on;box on;
plot3(y(51:100)',x2(:,5),z(51:100)','go');hold on;box on;
plot3(y(101:150)',x3(:,5),z(101:150)','ro');hold on;box on;
plot3(y(151:200)',x4(:,5),z(151:200)','ko');hold on;box on;
xlabel('Samples');ylabel('SE'); zlabel('Lable'); 
box on;
subplot(222)
plot3(y(1:50)',x1(:,6),z(1:50)','bo');hold on;box on;
plot3(y(51:100)',x2(:,6),z(51:100)','go');hold on;box on;
plot3(y(101:150)',x3(:,6),z(101:150)','ro');hold on;box on;
plot3(y(151:200)',x4(:,6),z(151:200)','ko');hold on;box on;
xlabel('Samples');ylabel('FE'); zlabel('Lable');box on;
subplot(223)
plot3(y(1:50)',x1(:,7),z(1:50)','bo');hold on;box on;
plot3(y(51:100)',x2(:,7),z(51:100)','go');hold on;box on;
plot3(y(101:150)',x3(:,7),z(101:150)','ro');hold on;box on;
plot3(y(151:200)',x4(:,7),z(151:200)','ko');hold on;box on;
xlabel('Samples');ylabel('AE'); zlabel('Lable');box on;
subplot(224)
plot3(y(1:50)',x1(:,9),z(1:50)','bo');hold on;box on;
plot3(y(51:100)',x2(:,9),z(51:100)','go');hold on;box on;
plot3(y(101:150)',x3(:,9),z(101:150)','ro');hold on;box on;
plot3(y(151:200)',x4(:,9),z(151:200)','ko');hold on;box on;
xlabel('Samples');ylabel('BD'); zlabel('Lable');box on;
legend('Good','Charge','Square','Pulse')

