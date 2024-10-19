D=xlsread('pridiction');
x=categorical(D(1:105,1));
y1=D(1:105,2);
y2=D(1:105,3);
y=[y1,y2];
figure
f=categorical(x);
bar(f,y)
xlabel('DNA Sequence','fontsize',15.5,'fontweight','bold')
ylabel('Shifting Response','fontsize',15.5,'fontweight','bold')
legend('Experimental Data')
