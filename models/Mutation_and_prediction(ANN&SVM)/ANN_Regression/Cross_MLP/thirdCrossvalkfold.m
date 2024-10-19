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
y=Y;
rng("default")
n = size(X,1);
%lambda can change from 0 to 1 to obtain minmum (see the relation in landa
%eq)
lambda = (0:0.5:200)*1e-3;
% Detrtmine kfold number
kfoldnum=282;
cvp = cvpartition(n,"KFold",kfoldnum);
cvloss = zeros(length(lambda),1);
for i = 1:length(lambda)
    cvMdl = fitrnet(X,y,"Standardize",true,"Lambda",lambda(i), ...
        "CVPartition",cvp,"LayerSizes",[15 5]);
    cvloss(i) = kfoldLoss(cvMdl);
    plot(lambda,cvloss)
    xlabel("Regularization Strength")
    ylabel("Cross-Validation Loss")
    %hold on
    drawnow
end
figure
plot(lambda,cvloss)
xlabel("Regularization Strength")
ylabel("Cross-Validation Loss")
[~,idx] = min(cvloss);
bestLambda = lambda(idx);
net=fitrnet(X,y,"Standardize",true,"Lambda",bestLambda,"LayerSizes",[15 5]);
cvmodel = crossval(net,'KFold',kfoldnum);
L = sqrt(kfoldLoss(cvmodel));
ycv = kfoldPredict(cvmodel);
validationMSE = sum((ycv - y ).^2) / numel(ycv );
r_squared=corr(y,ycv)^2;
figure
plotregression(y,ycv)

figure
plot (1:282,ycv, 1:282,y)
xlabel('DNA Seq','fontsize',12.5,'fontweight','bold')
ylabel('Shifting response','fontsize',12.5,'fontweight','bold')
legend('Pridected ','Experimental')