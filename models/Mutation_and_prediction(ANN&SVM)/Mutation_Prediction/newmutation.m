%% Start of program
clc;
clear;
close all;
%% Data Loading
% the best DNA sequence for FB1 shifting response
DNANEW='GAGGGGAGGAAGAGGGAGGGAAGAGGAGTG'
%% crate the new mutation (Number:90)
base={'A','C','G','T'};
j=1;
%DNANew=zeros(90,1);
for i=1:30
    DNAp=str2mat(DNANEW);
    if DNAp(i)==base{1}

        DNAp(i)=base{2};
        DNANew(j)={DNAp};

        DNAp(i)=base{3};
        DNANew (j+1)={DNAp};

        DNAp(i)=base{4};
        DNANew (j+2)={DNAp};

    elseif DNAp(i)==base{2}

        DNAp(i)=base{1};
        DNANew(j)={DNAp};

        DNAp(i)=base{3};
        DNANew (j+1)={DNAp};

        DNAp(i)=base{4};
        DNANew (j+2)={DNAp};

    elseif DNAp(i)==base{3}

        DNAp(i)=base{1};
        DNANew(j)={DNAp};

        DNAp(i)=base{2};
        DNANew (j+1)={DNAp};

        DNAp(i)=base{4};
        DNANew (j+2)={DNAp};

    elseif  DNAp(i)==base{4}

        DNAp(i)=base{1};
        DNANew(j)={DNAp};

        DNAp(i)=base{2};
        DNANew (j+1)={DNAp};

        DNAp(i)=base{3};
        DNANew (j+2)={DNAp};
    end
    j=j+3;
end

NewDNAmutation=cell2mat(DNANew');

%% Convert the base to the matrix (4*30 for each sequence)

[DNA]=NewDNAmutation
% convert the base to the matrix
%base(1)=A and A=[1;0;0;0]
%base(2)=C and C=[0;1;0;0]
%base(3)=G and G=[0;0;1;0]
%base(4)=T and T=[0;0;0;1]
base={'A','C','G','T'};
DNAm=DNA;
%DNAreponse=cell2mat(DNA(1:90,2));
for i=1:length(DNA);
for j=1:30;
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
X=DNA_num  % is DATAX
%% Data input for pridection (120 features input)
% X is the input of each DNA sequanc ( 90 cell of 4*30 Matrix)

[m1,n1]=size(X);
[m2,n2]=size(X{1,1});
inputs=zeros(m1,m2*n2);
ct=1;
for i=1:m1
    for j=1:n2
  inputs(i,ct:ct+3)=X{i,1}(:,j);  
  ct=ct+4;
  if j==n2
      ct=1;
  end
  if ct>=120
      break
  end
    end
end
NewMutationData=inputs;
