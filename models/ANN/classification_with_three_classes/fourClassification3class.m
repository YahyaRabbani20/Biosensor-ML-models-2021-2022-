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
ct1=1;ct2=1;
%for i=1:size (Y)
    % theroshold of Clasification (0,1) data avrage is 1.5 !
%if Y(i)<1.5
    %output(1,i)=0;
    %output(2,i)=1;
    %Y1(ct1)=Y(i);
    %ct1=ct1+1;

%else
   % output(1,i)=1;
    %output(2,i)=0;
    %Y2(ct2)=Y(i);
   % ct2=ct2+1;
%end
%end
for i=1:size (Y)
    % theroshold of Clasification (0,1) data avrage is 1.5 !
if Y(i)<=1.5
    output(1,i)=1;
    output(2,i)=0;
    output(3,i)=0;
    
 elseif (Y(i)>1.5 && Y(i)<=2)
    output(1,i)=0;
    output(2,i)=1;
    output(3,i)=0;
   
elseif Y(i)>2
    output(1,i)=0;
    output(2,i)=0;
    output(3,i)=1;
    
end
end

inputs=inputs';
%% Classification 

trainFcn = 'trainscg';  % Scaled conjugate gradient backpropagation.

% Create a Pattern Recognition Network
hiddenLayerSize = [10, 10];
net = patternnet(hiddenLayerSize, trainFcn);


net.divideFcn = 'dividerand';  % Divide data randomly
net.divideParam.trainRatio = 70/100;
net.divideParam.valRatio = 15/100;
net.divideParam.testRatio = 15/100;

% Train the Network
[net,tr] = train(net,inputs,output);













