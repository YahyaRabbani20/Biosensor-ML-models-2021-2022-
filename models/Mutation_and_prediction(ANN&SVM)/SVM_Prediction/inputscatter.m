clc, 
clear all;
load('response01.mat')
scatter(1:78, A,"o",...
    'MarkerEdgeColor','k',...
    'MarkerFaceColor','y')

xlabel('DNA Sequence','fontsize',12,'fontweight','bold')
ylabel('Shifting Response (Normalized)','fontsize',12,'fontweight','bold')
%legend('Experimental Data','fontsize',12,'fontweight','bold')