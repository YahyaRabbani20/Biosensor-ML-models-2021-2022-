
figure
X=1:202;
Y=sortrows([y,ycv],1)
bar(X,[Y(:,1),Y(:,2)])
xlabel('DNA Sequence','fontsize',15.5,'fontweight','bold')
ylabel('Shifting Response','fontsize',15.5,'fontweight','bold')
legend('Experimental Data', 'Model Prediction')

figure
error=abs(Y(:,1)-Y(:,2))
bar(Y(:,1),error)
figure
bar(sort(error))

figure
X=1:202;
Y=sortrows([y,ycv],1)
bar(X,Y(:,1))
hold on
plot(Y(:,2))
xlabel('DNA Sequence','fontsize',15.5,'fontweight','bold')
ylabel('Shifting Response','fontsize',15.5,'fontweight','bold')
legend('Experimental Data', 'Model Prediction')


figure
X=1:202;
Y=sortrows([y,ycv],2)
scatter(X,Y(:,1),'black','filled')
hold on
plot(Y(:,2),LineWidth=4,Color='g')
xlabel('DNA Sequence','fontsize',15.5,'fontweight','bold')
ylabel('Shifting Response','fontsize',15.5,'fontweight','bold')
legend('Experimental Data', 'Model Prediction')