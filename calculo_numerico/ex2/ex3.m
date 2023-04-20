clc 
clear all 
close all 

A=[];

for i=1:1:100
    for j=1:1:100
        A(i,j)=rand;
    end
end

[L,U,P]=lu(A);


deter=1;
for i=1:1:100
    for j=1:1:100
        if(i==j)
            deter=deter*U(i,j);
        end
    end
end

