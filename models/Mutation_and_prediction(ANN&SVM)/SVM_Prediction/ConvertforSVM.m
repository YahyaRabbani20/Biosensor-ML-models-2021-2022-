%% start of program
clc;
clear;
close all;
%% Data Loding 
%load('DATAY.mat');
load('NewDataForPredict.mat');
Xpridict=NewDataForPredict;

response=xlsread('new prediction.xlsx');
%response(:,3)=normalize(response(:,1), 'range' )
%response(:,3)=response(:,4)

for i=1:size (response)
%     % theroshold of Clasification (0,1) data avrage is 1.5 !
if response(i,3)<1.4
      y(i)=0;
else
     y(i)=1;
end
end
data=[Xpridict,y'];

