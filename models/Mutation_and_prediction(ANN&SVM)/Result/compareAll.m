clc
clear all
load('ANNprobabilityForkfold=50.mat')
ANNkfold=Score_Test;
load('ANNprobabilityForoneleaveout.mat')
ANNoneleaveout=Score_Test;
load('SVMposteriorProbabilty_test(Mutation)-k=10.mat')
SVMkfold=posteriorProbabilty_test;
load('SVMposteriorProbabilty_test(Mutation)-k=101.mat')
SVMoneleaveout=posteriorProbabilty_test;

figure
plot(ANNkfold(:,2),'b','LineWidth',1)
hold on
plot(ANNoneleaveout(:,2),'r','LineWidth',1)

plot(SVMkfold(:,2),'g','LineWidth',1)
hold on
plot(SVMoneleaveout(:,2),'black','LineWidth',1)


xlabel('New Mutaiom of DNA Sequence','fontsize',12,'fontweight','bold')
ylabel('Probability in class 1 (%)','fontsize',12,'fontweight','bold')
lgd = legend('ANN-Kfold cross validation','ANN- one leave out',...
    'SVM-Kfold cross validation','SVM- one leave out');
A=[(1:90)',ANNkfold(:,2),ANNoneleaveout(:,2),SVMkfold(:,2),SVMoneleaveout(:,2)]

figure
hold on
for i=1:90
    if A(i,4)>0.859 & A(i,5)>0.859 %& A(i,3)>0.86 & A(i,2)>0.86
 
      plot(i,A(i,2),'sr')
      plot(i,A(i,3),'*b')
      plot(i,A(i,4),'ok')
      plot(i,A(i,5),'dm')
  
    end
  
end
lgd = legend('ANN-Kfold cross validation','ANN- one leave out',...
    'SVM-Kfold cross validation','SVM- one leave out');
%B5=[B1;B2;B3;B4]'
xlabel('New Mutaiom of DNA Sequence','fontsize',10,'fontweight','bold')
ylabel('Probability in class 1 (%)','fontsize',10,'fontweight','bold')
%grid minor

%Experiment Result
E=[2.3953
2.2499
2.1192
2.3339
1.9615
2.3805
2.1806
2.644
2.4956
1.8955
2.8133
2.5635
3.0486
2.6636
2.691
1.9457
1.281
2.3716
2.4333
2.7545
3.0001
2.713
2.5566
2.1589
]
