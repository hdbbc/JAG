% % data=rand(100,2); 
close all
data=xlsread('qhjz.xlsx','G2:H201');
x = data(:,1);
y = data(:,2);
% figure(10)
% plot(y(1:100),'b*')
% hold on
% plot(y(101:200),'g*');legend('QH noisy data samples','QH original data samples');xlabel('samples');ylabel({'均方根值'});
% grid on;
% figure(11)
% plot(x(1:100),'b*')
% hold on
% plot(x(101:200),'g*');legend('QH noisy data samples','QH original data samples');;xlabel('samples');ylabel({'最大值'});
% grid on;

% 
% [center,U,obj_fcn] = FCMCluster(data,2); 
% plot(data(:,1),data(:,2),'o'); 
% hold on; 
% index1=find(U(1,:)==max(U));%找出划分为第一类的数据索引 
% index2=find(U(2,:)==max(U));%找出划分为第二类的数据索引 
% plot(data(index1,1),data(index1,2),'g*'); 
% hold on; 
% plot(data(index2,1),data(index2,2),'r*'); 
% hold on; 
% plot([center([1 2],1)],[center([1 2],2)],'*','color','k');
% data=rand(100,2); 
[center,U,obj_fcn] = FCMCluster(data,2); 
index1=find(U(1,:)==max(U));%找出划分为第一类的数据索引 
index2=find(U(2,:)==max(U));%找出划分为第二类的数据索引 
figure(1)
plot(data(:,1),data(:,2),'o'); xlabel({' 最大值'});ylabel({'均方根值'});box on
grid on

figure(1)
plot([center([1 2],1)],[center([1 2],2)],'*','color','k');xlabel({' |max|'});ylabel({'均方根值'});box on
plot(data(index1,1),data(index1,2),'g*'); 
hold on; 
plot(data(index2,1),data(index2,2),'r*'); legend('QH original data samples','QH noisy data samples');
% hold on; 
% plot([center([1 2],1)],[center([1 2],2)],'*','color','k');xlabel({' |max|'});ylabel({'均方根值'});box on
hold on; 
 plot(data(:,1),data(:,2),'o'); 
 grid on;
 figure(2)
 %% 
[C,I] = max(data(index1,2));
y0=C
x00=data(index1,1);
x0=x00(I,1)
% shift = max(data(index1,1));
% sigma = data(index1,1);
k=-(center(1,1)-center(1,2))/(center(2,1)-center(2,2))-0.4
mx=max(x)
x1 =1000:0.1:11000;
y1=k*(x1-x0)+y0+1000;
plot(data(index1,1),data(index1,2),'g*'); 
hold on; 
plot(data(index2,1),data(index2,2),'r*'); 
hold on; 
plot(x1,y1,'-','LineWidth',2);
legend('QH original data samples','QH noisy data samples','Linear programming');
hold on; 
plot([center([1 2],1)],[center([1 2],2)],'*','color','k');xlabel({' |max|'});ylabel({'均方根值'});box on
grid on;
figure
index1=find(U(1,:)==max(U));%找出划分为第一类的数据索引 
index2=find(U(2,:)==max(U));%找出划分为第二类的数据索引 
plot(data(index1,1),data(index1,2),'g*'); 
hold on; 
plot(data(index2,1),data(index2,2),'r*'); legend('Positive samples','Negative samples');
hold on; 
plot([center([1 2],1)],[center([1 2],2)],'*','color','k');xlabel({' |max|'});ylabel({'均方根值'});box on
hold on; 
 plot(data(:,1),data(:,2),'o'); 
%%
[C,I] = max(data(index1,1));

y0=C
x00=data(index1,2);
y00=data(index2,2);
x0=x00(I,1)

figure(32)
plot(index1,x00,'b*'),box on;
hold on
plot(index2,y00,'r*'),box on;
z1=ones(size(x00));
z2=2*ones(size(y00));
% 
% 
figure(33)
plot3(index1,x00,ones(size(x00)),'b*'),xlabel('样本数'),ylabel('均方根值'),zlabel('类'),box on;
hold on
plot3(index2,y00,2*ones(size(y00)),'r*'),box on;
grid on

%%
x01=data(index1,1);
y01=data(index2,1);

figure(34)
plot(index1,x01,'b*'),box on;
hold on
plot(index2,y01,'r*'),box on;
z1=ones(size(x01));
z2=2*ones(size(y01));
% 
% 
figure(35)
plot3(index1,x01,ones(size(x01)),'b*'),xlabel('样本数'),ylabel('均方根值'),zlabel('类'),box on;
hold on
plot3(index2,y01,2*ones(size(y01)),'r*'),box on;
grid on






