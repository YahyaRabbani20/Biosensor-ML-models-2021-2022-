%% start of program
clc;
clear;
close all;
%% Data Loding 
load('DATAY.mat');
load('DATAX.mat');
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
trainRatio=0.8;valRatio=0.1;testRatio=0.1;
[trainInd,valInd,testInd] = dividerand(n,trainRatio,valRatio,testRatio);
X_Train=X(trainInd,:);Y_Train=y(trainInd);
X_Val=X(valInd,:);Y_Val=y(valInd);
X_Test=X(testInd,:);Y_Test=y(testInd);
Table_Train=table(X_Train,Y_Train);
Table_Val=table(X_Val,Y_Val);
Mdl = fitcnet(X_Train,Y_Train,"ValidationData",{X_Val,Y_Val},"Verbose",0);
iteration = Mdl.TrainingHistory.Iteration;
trainLosses = Mdl.TrainingHistory.TrainingLoss;
valLosses = Mdl.TrainingHistory.ValidationLoss;
plot(iteration,trainLosses,iteration,valLosses)
legend(["Training","Validation"])
xlabel("Iteration")
ylabel("Cross-Entropy Loss")
[~,minIdx] = min(valLosses);
iteration(minIdx)
[Train_Label,Train_Score]=predict(Mdl,X_Train);
[Val_Label,Val_Score]=predict(Mdl,X_Val);
[Test_Label,Test_Score]=predict(Mdl,X_Test);
Accuracy_Train = 1 - loss(Mdl,X_Train,Y_Train,"LossFun","classiferror");
Accuracy_Val = 1 - loss(Mdl,X_Val,Y_Val,"LossFun","classiferror");
Accuracy_Test = 1 - loss(Mdl,X_Test,Y_Test,"LossFun","classiferror");
display([Accuracy_Train,Accuracy_Val,Accuracy_Test]);
figure
plotconfusion(Y_Train',Train_Label');
figure
plotconfusion(Y_Val',Val_Label');
figure
plotconfusion(Y_Test',Test_Label');
[fpr_Train0,tpr_Train0,~,auc_Train] = perfcurve(Y_Train,Train_Score(:,1),0);
[fpr_Train1,tpr_Train1,~,~] = perfcurve(Y_Train,Train_Score(:,2),1);
[fpr_Val0,tpr_Val0,~,auc_Val] = perfcurve(Y_Val,Val_Score(:,1),0);
[fpr_Val1,tpr_Val1,~,~] = perfcurve(Y_Val,Val_Score(:,2),1);
[fpr_Test0,tpr_Test0,~,auc_Test] = perfcurve(Y_Test,Test_Score(:,1),0);
[fpr_Test1,tpr_Test1,~,~] = perfcurve(Y_Test,Test_Score(:,2),1);

figure
plot(fpr_Train0,tpr_Train0,LineWidth=1.5)
hold on
plot(fpr_Train1,tpr_Train1,LineWidth=1.5)
xlabel('False positive rate','fontsize',12,'fontweight','bold')
ylabel('True positive rate','fontsize',12,'fontweight','bold')
%title('ROC Curve for Testdata')
plot([0,1],[0,1],'--k',LineWidth=1.5)
legend('Class0','Class1','Random Classifier');
hold off

figure
plot(fpr_Val0,tpr_Val0,LineWidth=1.5)
hold on
plot(fpr_Val1,tpr_Val1,LineWidth=1.5)
xlabel('False positive rate','fontsize',12,'fontweight','bold')
ylabel('True positive rate','fontsize',12,'fontweight','bold')
%title('ROC Curve for Testdata')
plot([0,1],[0,1],'--k',LineWidth=1.5)
legend('Class0','Class1','Random Classifier');
hold off

figure
plot(fpr_Test0,tpr_Test0,LineWidth=1.5)
hold on
plot(fpr_Test1,tpr_Test1,LineWidth=1.5)
xlabel('False positive rate','fontsize',12,'fontweight','bold')
ylabel('True positive rate','fontsize',12,'fontweight','bold')
%title('ROC Curve for Testdata')
plot([0,1],[0,1],'--k',LineWidth=1.5)
legend('Class0','Class1','Random Classifier');
Train_Label(:,2)=Y(trainInd);
Val_Label(:,2)=Y(valInd);
Test_Label(:,2)=Y(testInd);

[fpr0,tpr0,~,auc] = perfcurve(y,posteriorProbabilty_train(:,1),0);
plot(fpr0,tpr0,LineWidth=1.5)
hold on
[fpr1,tpr1,~,~] = perfcurve(y,posteriorProbabilty_train(:,2),1);
plot(fpr1,tpr1,LineWidth=1.5)
xlabel('False positive rate','fontsize',12,'fontweight','bold')
ylabel('True positive rate','fontsize',12,'fontweight','bold')
%title('ROC Curve')
plot([0,1],[0,1],'--k',LineWidth=1.5)
legend('Class0','Class1','Random Classifier');


figure
hold on
for i=1:size (Train_Label,1)
if Train_Label(i,1)==0
    plot(i,Train_Label(i,2),'ro')
else
    plot(i,Train_Label(i,2),'gs')
end
end
yline(1.5, 'b--', 'LineWidth', 2);
legend('Class1','Class0');
hold off
figure
hold on
for i=1:size (Val_Label,1)
if Val_Label(i,1)==0
    plot(i,Val_Label(i,2),'ro')
else
    plot(i,Val_Label(i,2),'gs')
end
end
yline(1.5, 'b--', 'LineWidth', 2);
legend('Class1','Class0');
hold off
figure
hold on
for i=1:size (Test_Label,1)
if Test_Label(i,1)==0
    plot(i,Test_Label(i,2),'ro')
else
    plot(i,Test_Label(i,2),'gs')
end
end
yline(1.5, 'b--', 'LineWidth', 2);
legend('Class1','Class0');
hold off



figure
hold on
for i=1:size (Train_Label,1)
if Train_Label(i,1)==0
    plot(i,Train_Label(i,2),'ro')
else
    plot(i,Train_Label(i,2),'gs')
end
end
yline(1.5, 'b--', 'LineWidth', 2);
legend('Class1','Class0');
hold off
figure
hold on
for i=1:size (Val_Label,1)
if Val_Label(i,1)==0
    plot(i,Val_Label(i,2),'ro')
else
    plot(i,Val_Label(i,2),'gs')
end
end
yline(1.5, 'b--', 'LineWidth', 2);
legend('Class1','Class0');
hold off
figure
hold on
for i=1:size (Test_Label,1)
if Test_Label(i,1)==0
    plot(i,Test_Label(i,2),'ro')
else
    plot(i,Test_Label(i,2),'gs')
end
end
yline(1.5, 'b--', 'LineWidth', 2);
legend('Class1','Class0');
hold off

xlabel('DNA sequence number','fontsize',12,'fontweight','bold')
ylabel('Experimental shifting response (nm)','fontsize',12,'fontweight','bold')




    
    
    












