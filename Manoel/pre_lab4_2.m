Gp1=tf([1],[1 4.5]);
Gp2=tf([1],[1 0.2]);

b0=18;
ma=Gp1*Gp2*b0;
q0=2
R0=16.7000
T0=0.001;
a=15.7102;

while(q0>Umax/R0) 
  
    mad=c2d(ma,T0);

    b1=mad.num{1}(2);

    b2=mad.num{1}(3);

    a1=mad.den{1}(2);

    a2=mad.den{1}(3);

    q0=1/sum(mad.num{1});

    q1=q0*a1;
    q2=q0*a2;
    p1=q0*b1;
    p2=q0*b2;

    GDB=tf([q0 q1 q2],[1 -p1 -p2],T0);

    %fu=feedback(GDB,mad);
    %infor=stepinfo(R0*fu);
    %a=infor.Peak;
    
    T0=T0 + 0.001
end

T0
step(fu)