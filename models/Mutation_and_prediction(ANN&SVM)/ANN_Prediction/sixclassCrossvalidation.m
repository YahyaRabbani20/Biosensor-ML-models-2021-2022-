%% start of program
clc;
clear;
close all;
%% Data Loding 
load('DATAY.mat');
load('DATAX.mat');
load('dataTest.mat');
X_Test=data(:,1:end-1);
Y_Test=data(:,end);
[m1,n1]=size(X);
[m2,n2]=size(X{1,1});
inputs=zeros(m1,m2*n2);
ct=1;
for i=1:m1
    for j=1:n2
  inputs(i,ct:ct+3)=X{i,1}(:,j);  
  ct=ct+4;
  if j==n2
      ct=1;
  end
  if ct>=120
      break
  end
    end
end
for i=1:size (Y)
    % theroshold of Clasification (0,1) data avrage is 1.5 !
if Y(i)<1.5
    output(i,1)=0;
else
    output(i,1)=1;
end
end
rng("default")
n = size(inputs,1);
%kfold Number
K_No=30;
cvp = cvpartition(n,"KFold",K_No);
lambda = (0:0.5:100)*1e-3;
cvloss = zeros(length(lambda),1);
for i = 1:length(lambda)
    cvMdl = fitcnet(inputs,output,"Standardize",true,"Lambda",lambda(i), ...
        "CVPartition",cvp,"LayerSizes",[10 5]);
    cvloss(i) = kfoldLoss(cvMdl);
   plot(lambda,cvloss) 
   xlabel("Regularization Strength")
   ylabel("Cross-Validation Loss")
end
figure
plot(lambda,cvloss)
xlabel("Regularization Strength")
ylabel("Cross-Validation Loss")
[~,idx] = min(cvloss);
bestLambda = lambda(idx);
net=fitcnet(inputs,output,"Standardize",true,"Lambda",bestLambda,"LayerSizes",[10 5]);
cvmodel = crossval(net,'KFold',K_No);
Accuracy_kfold_crossvalidation =1- kfoldLoss(cvmodel);
[label,score] = kfoldPredict(cvmodel);
figure
plotconfusion(output',label')
figure
[fpr0,tpr0,~,auc] = perfcurve(output,score(:,1),0);
plot(fpr0,tpr0)
hold on
[fpr1,tpr1,~,~] = perfcurve(output,score(:,2),1);
plot(fpr1,tpr1)
xlabel('False positive rate')
ylabel('True positive rate')
title('ROC Curve')
legend('Class0','Class1');
Y(:,2)=label;
ct1=1;ct2=1;
for i=1:size (Y)
if Y(i,1)<1.5
    Y0(ct1,:)=Y(i,:);
    ct1=ct1+1;
else
    output(i,1)=1;
    Y1(ct2,:)=Y(i,:);
    ct2=ct2+1;
end
end

figure
hold on
for i=1:size (Y)
if Y(i,2)==0
    plot(i,Y(i,1),'ro')
else
    plot(i,Y(i,1),'gs')
end
end

yline(1.5, 'b--', 'LineWidth', 2);
legend('Class1','Class0');
[Label_Test,Score_Test]=predict(net,X_Test);
figure
plotconfusion(Y_Test',Label_Test')
figure
[fpr0_Test,tpr0_Test,~,auc_Test] = perfcurve(Y_Test,Score_Test(:,1),0);
plot(fpr0_Test,tpr0_Test)
hold on
[fpr1_Test,tpr1_Test,~,~] = perfcurve(Y_Test,Score_Test(:,2),1);
plot(fpr1_Test,tpr1_Test)
xlabel('False positive rate')
ylabel('True positive rate')
title('ROC Curve')
legend('Class0','Class1');
