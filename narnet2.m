%plotting
tt = 1:size(Pred,2);
figure(1);
plot(tt,Pred,'r') %plot predicted data
ylim([0 1]);
title('forecasting')
figure(2);
plot(tt,data(1,[1:size(Pred,2)]),'b') %plot original data
ylim([0 1]);
title('original')

for i=2:size(Pred,2)
er2(1,i)=abs(mean(Pred(1:i))-median(Pred(1:i)));
end
figure(3);
plot(er2,'r')

[TF1,x1] = ischange(er2,'var','MaxNumChanges',1);
idx1 = find (TF1==1)
Threshold = x1(1,idx1-1);
Var_change = abs(x1(1,idx1-1)-x1(1,idx1))

% figure(4);
% plot(er2)
% hold on
% stairs(x1,'linewidth',1.5)
% legend('Data','Segment variance','Location','NW')

% fault declaration
name = 'Fault detected at';   
Statement1 = [name,' time step ',num2str(idx1), ' when variance is more than ', num2str(Threshold)];
Statement2 = [name,' time step ',num2str(idx1), ' when difference in variance is more than ', num2str(Var_change)];
disp(Statement1)
disp(Statement2)
