%clc; clear all; close all;
S1=xlsread('C:\Users\jhimli\Desktop\denoisedfeatures.xlsx','Sheet1'); %denoise (with enhance)

%take average of two channels
i=1; % i = 1:6 features- skew,kur,mean,var,entropy,energy, i=1:7 (rms of xden) for xden(S7) for org (S8)
A1= S1(i,:)'; A2= S1(i+7,:)';
B1= S1(i+14,:)'; B2= S1(i+21,:)';
C1= S1(i+28,:)'; C2= S1(i+35,:)';
D1= S1(i+42,:)'; D2= S1(i+49,:)';

%normalize y-axis (feature values)
A1= (A1-min(A1))/(max(A1)-min(A1)); A2= (A2-min(A2))/(max(A2)-min(A2));
B1= (B1-min(B1))/(max(B1)-min(B1)); B2= (B2-min(B2))/(max(B2)-min(B2));
C1= (C1-min(C1))/(max(C1)-min(C1)); C2= (C2-min(C2))/(max(C2)-min(C2));
D1= (D1-min(D1))/(max(D1)-min(D1)); D2= (D2-min(D2))/(max(D2)-min(D2));

A = ((A1+A2)/2)'; B = ((B1+B2)/2)'; C = ((C1+C2)/2)'; D = ((D1+D2)/2)';

% figure(1);
% subplot(4,1,1); plot(A,'b')
% subplot(4,1,2); plot(B,'b')
% subplot(4,1,3); plot(C,'r')
% subplot(4,1,4); plot(D,'k')
% title('Kurtosis')
%======================================================================
rng(10);
data = D;  forecast = 2;
error = zeros(1,size(D,2)); perf1 = zeros(1,size(D,2));
  
%col = 1829; 
for i = 4:size(D,2) 

T = data(1,1:i); T= num2cell(T);

%Create a NAR network. Define the feedback delays and size of the hidden layers.
net = narnet(1:2,10);

%Prepare the time series data using preparets. This function automatically shifts input and target time series 
%by the number of steps needed to fill the initial input and layer delay states.
[Xs,Xi,Ai,Ts] = preparets(net,{},{},T);

%Train the NAR network. The train function trains the network in an open loop (series-parallel architecture), including the validation and testing steps.
net = train(net,Xs,Ts,Xi,Ai);
%view(net)

%Calculate the network output Y, final input states Xf, and final layer states Af of the open-loop network from the network input Xs, initial input states Xi, and initial layer states Ai.
[Y,Xf,Af] = net(Xs,Xi,Ai);

%Calculate the network performance.
perf = perform(net,Ts,Y);
perf1(i,i) = perf;

%To predict the output for the next 20 time steps, first simulate the network in closed loop form.
[netc,Xic,Aic] = closeloop(net,Xf,Af);
%view(netc)

%To simulate the network 2 time steps ahead, input an empty cell array of length 15. 
%The network requires only the initial conditions given in Xic and Aic.

Yc = netc(cell(0,forecast),Xic,Aic);

Y = cell2mat(Y);
Yc1 = cell2mat(Yc);
Pred = [Y Yc1];

org = data(1,[1:size(Pred,2)]);
RMSE = sqrt(mean((Pred - org).^2)); % on whole TS
%org1 = data(1,[col+1:col+forecast]);
%RMSE1 = sqrt(mean((Yc1 - org1).^2)) % on only forecasting data series- 15 future timesteps
error(1,i) = RMSE;
end



