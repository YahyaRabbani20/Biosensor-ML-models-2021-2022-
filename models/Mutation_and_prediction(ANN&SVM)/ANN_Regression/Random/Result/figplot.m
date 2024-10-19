figure
plot (1:15,testTargets,'Color','r')
hold on
plot (1:15,testOutputs,'Ok')
xlabel('DNA Seq','fontsize',15.5,'fontweight','bold')
ylabel('Shifting Response','fontsize',15.5,'fontweight','bold')
legend('Pridected ','Experimental')
bar(1:15,[testTargets',testOutputs'])

figure
error=abs(testTargets'-testOutputs')
bar(testOutputs,error)
figure
bar(sort(error))