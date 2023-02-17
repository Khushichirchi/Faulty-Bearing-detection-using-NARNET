clc; clear all; close all;

S7=xlsread('C:\Users\jhimli\Desktop\TestdataSet1.xlsx','Sheet7'); %denoise (with enhance)
S8=xlsread('C:\Users\jhimli\Desktop\TestdataSet1.xlsx','Sheet8'); %org (without enhance)

i=2; % i = 1:6 features- skew,kur,mean,var,entropy,energy, i=1:7 (rms of xden) for xden(S7) for org (S8)
%range= 1400:1700;
A1= S7(i,:)'; A2= S7(i+7,:)';
B1= S7(i+14,:)'; B2= S7(i+21,:)';
C1= S7(i+28,:)'; C2= S7(i+35,:)';
D1= S7(i+42,:)'; D2= S7(i+49,:)';

%normalize y-axis (feature values)
A1= (A1-min(A1))/(max(A1)-min(A1)); A2= (A2-min(A2))/(max(A2)-min(A2));
B1= (B1-min(B1))/(max(B1)-min(B1)); B2= (B2-min(B2))/(max(B2)-min(B2));
C1= (C1-min(C1))/(max(C1)-min(C1)); C2= (C2-min(C2))/(max(C2)-min(C2));
D1= (D1-min(D1))/(max(D1)-min(D1)); D2= (D2-min(D2))/(max(D2)-min(D2));

A = (A1+A2)/2; B = (B1+B2)/2;C = (C1+C2)/2;D = (D1+D2)/2;

% figure(1);
% title('kurtosis')
% subplot(4,1,1)
% plot(A,'b')
% subplot(4,1,2)
% plot(B,'b')
% subplot(4,1,3)
% plot(C,'r')
% subplot(4,1,4)
% plot(D,'k')
%%================================================================================
range = 1:1500;
Anew = A(range,:); Cnew = C(range,:);
randIdcs_A = randperm(length(Anew),100); Anew_rand = Anew(randIdcs_A);
randIdcs_C = randperm(length(Cnew),100); Cnew_rand = Cnew(randIdcs_C);

meanData = [Anew_rand Cnew_rand];

x = meanData(:,1); y = meanData(:,2);

[p,h] = ranksum(x,y)