%% start of program
clc;
clear;
close all;
%% Data Loding 
load('DATAY.mat');
load('DATAX.mat');
[m1,n1]=size(X);
[m2,n2]=size(X{1,1});
X1=zeros(m1,m2*n2);
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
inputs=inputs';
targets=Y';
%% Create a Fitting Network
inputlayerSize = 120;
hiddenLayerSize =[5 5];
TF = {'tansig','purelin'};
net = newff(inputs,targets,hiddenLayerSize,TF);
net.divideFcn = 'dividerand';   % Divide data randomly
net.divideMode = 'sample';   % Divide up every sample
net.divideParam.trainRatio = 70/100;
net.divideParam.valRatio = 2/100;
net.divideParam.testRatio = 28/100;
net.trainFcn = 'trainlm';  % Levenberg-Marquardt
net.performFcn = 'mse';  % Mean squared error
net.plotFcns = {'plotperform','ploterrhist','plotregression','plotfit'};
net.trainParam.showWindow=true;
net.trainParam.showCommandLine=false;
net.trainParam.show=1;
net.trainParam.epochs=10000;
net.trainParam.goal=1e-8;
net.trainParam.max_fail=20;
%% Train the Network

[net,tr] = train(net,inputs,targets);
%% Test the Network
outputs = net(inputs);
errors = gsubtract(targets,outputs);
performance = perform(net,targets,outputs);
trainInputs = inputs(:,tr.trainInd);
trainTargets = targets(:,tr.trainInd);
trainOutputs = outputs(:,tr.trainInd);
trainErrors = trainTargets-trainOutputs;
trainPerformance = perform(net,trainTargets,trainOutputs);
figure
plotregression(trainTargets,trainOutputs)

valInputs = inputs(:,tr.valInd);
valTargets = targets(:,tr.valInd);
valOutputs = outputs(:,tr.valInd);
valErrors = valTargets-valOutputs;
valPerformance = perform(net,valTargets,valOutputs);
figure
plotregression(valTargets,valOutputs)

testInd=tr.testInd;
testInputs = inputs(:,tr.testInd);
testTargets = targets(:,tr.testInd);
testOutputs = outputs(:,tr.testInd);
testError = testTargets-testOutputs;
testPerformance = perform(net,testTargets,testOutputs);
figure
plotregression(testTargets,testOutputs)
figure
plot (1:30,testTargets,'Color','r')
hold on
plot (1:30,testOutputs,'Marker','square','Color','g')
xlabel('DNA Seq','fontsize',15.5,'fontweight','bold')
ylabel('Shifting Response','fontsize',15.5,'fontweight','bold')
legend('Pridected ','Experimental')