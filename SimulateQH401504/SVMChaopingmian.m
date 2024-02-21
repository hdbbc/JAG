clear; close all; clc;
load fisheriris.mat
data = meas(51:end,3:4);   
group = species(51:end);               
idx = randperm(size(data,1));
N = length(idx);
%%SVM train
T = floor(N*0.9); 
xdata = data(idx(1:T),:);
xgroup = group(idx(1:T));
svmStruct = svmtrain(xdata,xgroup,'Showplot',true);
% SVM predict

P = floor(N*0.1); 
ydata = data(idx(T+1:end),:);
ygroup = group(idx(T+1:end));
% pgroup = svmclassify(svmStr,ydata,true);  
pgroup = svmclassify(svmStruct,ydata,'Showplot',true);
hold on;
plot(ydata(:,1),ydata(:,2),'bs','Markersize',12);
accuracy1 = sum(strcmp(pgroup,ygroup))/P*100;
hold off;