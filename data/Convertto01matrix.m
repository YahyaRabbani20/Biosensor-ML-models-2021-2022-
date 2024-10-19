%% Start of program
clc;
clear;
close all;
%% Data Loading
[~,~,DNA]=xlsread('Summary_test_data_(7,5)');

%% convert the base to the matrix
%base(1)=A and A=[1;0;0;0]
%base(2)=C and C=[0;1;0;0]
%base(3)=Gand  G=[0;0;1;0]
%base(4)=T and T=[0;0;0;1]
base={'A','C','G','T'};
DNAm=cell2mat(DNA(2:283,1));
DNAreponse=cell2mat(DNA(2:283,2));
for i=1:length(DNAreponse)
for j=1:30
    if DNAm(i,j)==base{1}
        DNA_num {i,1}(:,j)=[1;0;0;0];
    elseif DNAm(i,j)==base{2}
        
        DNA_num{i,1}(:,j)=[0;1;0;0];
    elseif DNAm(i,j)==base{3}
        
       DNA_num{i,1}(:,j)=[0;0;1;0];
    elseif DNAm(i,j)==base{4}
        
        DNA_num{i,1}(:,j)=[0;0;0;1];
    end
end
end
%% Data input and Output
% X is the input of each DNA sequanc ( 282 cell of 4*30 Matrix)
% Y is the shiftting response (282)
X=DNA_num;
Y=DNAreponse;
