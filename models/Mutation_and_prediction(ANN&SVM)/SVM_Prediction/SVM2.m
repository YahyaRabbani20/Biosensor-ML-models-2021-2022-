%% start of program
clc;
clear all;
close all;
%% Data Loding 
load('DATAY.mat');
load('DATAX.mat');
load('dataTest.mat');
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
X=inputs;

for i=1:size (Y)
    % theroshold of Clasification (0,1) data avrage is 1.5 !
if Y(i)<1.5
    y(i,1)=0;
else
    y(i,1)=1;
end
end
n = size(X,1);
Kfold_No=101;
evaluated_Mdl = fitcsvm(X,y,'OptimizeHyperparameters','all','HyperparameterOptimizationOptions',struct('AcquisitionFunctionName','expected-improvement-plus','Repartition',true,'Kfold',Kfold_No,'MaxObjectiveEvaluations',60));
final_model=fitcsvm(X,y,'KernelFunction',evaluated_Mdl.ModelParameters.KernelFunction,'KernelScale',evaluated_Mdl.ModelParameters.KernelScale,'BoxConstraint',evaluated_Mdl.ModelParameters.BoxConstraint,'Standardize',evaluated_Mdl.ModelParameters.StandardizeData,'Kfold',Kfold_No);
test_model=fitcsvm(X,y,'KernelFunction',evaluated_Mdl.ModelParameters.KernelFunction,'KernelScale',evaluated_Mdl.ModelParameters.KernelScale,'BoxConstraint',evaluated_Mdl.ModelParameters.BoxConstraint,'Standardize',evaluated_Mdl.ModelParameters.StandardizeData);
Accuracy_kfold_crossvalidation =1- kfoldLoss(final_model,'LossFun', 'ClassifError');
[label,score] = kfoldPredict(final_model);
figure
plotconfusion(y',label')
figure
[fpr0,tpr0,~,auc] = perfcurve(y,score(:,1),0);
plot(fpr0,tpr0)
hold on
[fpr1,tpr1,~,~] = perfcurve(y,score(:,2),1);
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
label_Test = predict(test_model,data(:,1:end-1));
figure
plotconfusion(data(:,end)',label_Test')
% Posterior probabilty is computed based on a transformation so is not
% often used in SVM!
ScoreSVMModel = fitPosterior(test_model);
[~,posteriorProbabilty_train]=predict(ScoreSVMModel,X);
[~,posteriorProbabilty_test]=predict(ScoreSVMModel,data(:,1:end-1));