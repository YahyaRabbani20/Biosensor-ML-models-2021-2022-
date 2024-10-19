load('NewMutationData.mat');
X_Test=NewMutationData(:,1:end);
% Y_Test=NewMutationData(:,end);
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

figure
hold on
for i=1:size (Y_Test)
if Label_Test(i,1)==0
    plot(i,response(i,3),'ro')
else
    plot(i,response(i,3),'gs')
end
end
xlabel('DNA Sequence','fontsize',12,'fontweight','bold')
ylabel('Shifting response (nm)- Normalize','fontsize',12,'fontweight','bold') 