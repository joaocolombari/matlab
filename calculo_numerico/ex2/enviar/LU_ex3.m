function [L,U,P] = LU_ex3(A)

n=size(A,1);
m=zeros(n);
L=zeros(n);
P=eye(n);

for r=1:n-1
    [V,k]=max(abs(A(r:n,r)));
    k=k+r-1;
    if(k~=r)
        temp=A(k,:);
        A(k,:)=A(r,:);
        A(r,:)=temp;
        
        temp=P(k,:);
        P(k,:)=P(r,:);
        P(r,:)=temp;
        
        temp=L(k,:);
        L(k,:)=L(r,:);
        L(r,:)=temp;
    end
    L(r,r)=1;
    for i=r+1:n
        m(i,r)=-A(i,r)/A(r,r);
        L(i,r)=-m(i,r);
        for j=r:n
            A(i,j)=A(i,j)+m(i,r)*A(r,j);
        end
    end
end

L(n,n)=1;
U=A;
end

