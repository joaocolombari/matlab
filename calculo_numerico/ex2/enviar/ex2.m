clc 
clear all 
close all 

A=[];

for i=1:1:10
    for j=1:1:10
        if(i==j)
            A(i,j)=1;
        elseif(i<j)
            A(i,j)=0;
        else
            A(i,j)=rand;
        end
    end
end

A
inv(A)
A*ans