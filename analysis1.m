%clc; clear all; close all;
%load 'I:\IMS\MatFiles_1stTest\A.mat';% pen drive
%load 'I:\IMS\MatFiles_1stTest\B.mat';
%load 'I:\IMS\MatFiles_1stTest\C.mat';
%load 'I:\IMS\MatFiles_1stTest\D.mat';
%load 'I:\IMS\MatFiles_1stTest\E.mat';
load 'I:\IMS\MatFiles_1stTest\F.mat';
%load 'I:\IMS\MatFiles_1stTest\G.mat';
%load 'I:\IMS\MatFiles_1stTest\H.mat';


Fnew1=[]; Fnew2=[]; Fnew3=[]; Fnew4=[]; Fnew5=[]; Fnew6=[]; Fnew7=[]; Fnew8=[];

for i = 1:size(F,2)
x = F(:,i);  
N = 5; wname = 'db10';
[c,l] = wavedec(x,N,wname);
a3 = appcoef(c,l,wname,N);
[cd1,cd2,cd3, cd4, cd5] = detcoef(c,l,[1 2 3 4 5]);
xden = wdenoise(x,N,'DenoisingMethod','UniversalThreshold', 'Wavelet', wname);

% %features
% 
f1=skewness(a3); f2=kurtosis(a3); f3=mean(a3); f4=var(a3); f5=entropy(a3); f6=sum(a3.^2);

f1d1=skewness(cd1); f2d1=kurtosis(cd1); f3d1=mean(cd1); f4d1=var(cd1); f5d1=entropy(cd1); f6d1=sum(cd1.^2);
f1d2=skewness(cd2); f2d2=kurtosis(cd2); f3d2=mean(cd2); f4d2=var(cd2); f5d2=entropy(cd2); f6d2=sum(cd2.^2);
f1d3=skewness(cd3); f2d3=kurtosis(cd3); f3d3=mean(cd3); f4d3=var(cd3); f5d3=entropy(cd3); f6d3=sum(cd3.^2);
f1d4=skewness(cd4); f2d4=kurtosis(cd4); f3d4=mean(cd4); f4d4=var(cd4); f5d4=entropy(cd4); f6d4=sum(cd4.^2);
f1d5=skewness(cd5); f2d5=kurtosis(cd5); f3d5=mean(cd5); f4d5=var(cd5); f5d5=entropy(cd5); f6d5=sum(cd5.^2);

f1den=skewness(xden); f2den=kurtosis(xden); f3den=mean(xden); f4den=var(xden); f5den=entropy(xden); f6den=sum(xden.^2);

f1x=skewness(x); f2x=kurtosis(x); f3x=mean(x); f4x=var(x); f5x=entropy(x); f6x=sum(x.^2);


X = [f1 f1d1 f1d2 f1d3 f1d4 f1d5 f1den f1x;
        f2 f2d1 f2d2 f2d3 f2d4 f2d5 f2den f2x;
           f3 f3d1 f3d2 f3d3 f3d4 f3d5 f3den f3x;
               f4 f4d1 f4d2 f4d3 f4d4 f4d5 f4den f4x;
                    f5 f5d1 f5d2 f5d3 f5d4 f5d5 f5den f5x;
                        f6 f6d1 f6d2 f6d3 f6d4 f6d5 f6den f6x];

F_approx = X(:,1); F_d1 = X(:,2);  F_d2 = X(:,3);  F_d3 = X(:,4);  F_d4 = X(:,5);  F_d5 = X(:,6);
F_den = X(:,7); F_x = X(:,8); 

F1= [F_approx F_d1 F_d2 F_d3 F_d4 F_d5 F_den F_x];

Fnew1(:,i) = F_approx; % row= #features, col= #time series
Fnew2(:,i) = F_d1;
Fnew3(:,i) = F_d2;
Fnew4(:,i) = F_d3;
Fnew5(:,i) = F_d4;
Fnew6(:,i) = F_d5;
Fnew7(:,i) = F_den;
Fnew8(:,i) = F_x;
 end

% %save features in excel file
%  filename = 'C:\Users\jhimli\Desktop\IntelliPredikt\Analysis1.xlsx';
% for j=1:7   % 7 = total number of exracted features
% sheet = j;
% xlswrite(filename,Fnew(:,j),sheet,'A1');
% % sheet=3;
% % xlswrite(filename,MGF,sheet,'A1');
% end
% 

figure(2);
subplot (2,1,1)
plot(F(:,1),'b-'); % for 1st TS data
title('Actual vibration signal for faulty bearing')
hold on;
subplot(2,1,2)
plot(xden,'b-')
title('Enhanced signal for faulty bearing')


%%===============================================================================================================
% plot wavelets filters
% [phi,psi,xval] = wavefun('db15',10);
% plot(xval,psi); 
% [psi,xval] = wavefun('morl',10);
% plot(xval,psi); 