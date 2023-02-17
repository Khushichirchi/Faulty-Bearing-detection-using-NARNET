clc; clear all; close all;

Files=dir('I:\IMS\1st_test\1st_test\*.*');
dir_to_search = 'I:\IMS\1st_test\1st_test\';
%======================================================================================

%Files=dir('C:\Users\jhimli\Desktop\New folder\SampleData\*.*');
%dir_to_search = 'C:\Users\jhimli\Desktop\New folder\SampleData\';
txtpattern = fullfile(dir_to_search, '*.*');
dinfo = dir(txtpattern);

i=1;
for k=3:length(dinfo)
   thisfilename = fullfile(dir_to_search, dinfo(k).name);
   thisdata = load(thisfilename); %load just this file
   fprintf( 'File #%d, "%s", maximum value was: %g\n', k, thisfilename, max(thisdata(:)));
A(:,i) = thisdata(:,1);
B(:,i) = thisdata(:,2);
C(:,i) = thisdata(:,3);
D(:,i) = thisdata(:,4);
E(:,i) = thisdata(:,5);
F(:,i) = thisdata(:,6);
G(:,i) = thisdata(:,7);
H(:,i) = thisdata(:,8);
i=i+1;
end

