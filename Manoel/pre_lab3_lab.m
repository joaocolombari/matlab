%%%%%%%%%%%%%%%%%%%%
% pre lab manoel   %
%%%%%%%%%%%%%%%%%%%%

% Definir minha funcao normalmente:

Gp1=tf([1],[1 4.5]);
Gp2=tf([1],[1 0.2]);

b0=18;
ma=Gp1*Gp2*b0

%rlocus(a)

% Aqui ja deixo o comando rlocus(a) indicado. Determinei q0, segue:

q0=0.577;
b=ma*q0;
Kpf = 1.0436;
Yss=23.9;
Umax=10;
r0=0.7*Yss;
R0=round(r0,1)

% Agora, encontrar a frequencia para o T0:

mf=feedback(q0*ma,1);
infor=stepinfo(mf);
atraso=infor.SettlingTime
ganho=0.01027*infor.SettlingMax;
t0 = 0.1*infor.RiseTime;
T0 = round(t0,3);

mad=c2d(ma,T0);
mfd=c2d(mf,T0);


%rltool(mad)

% Rodado o comando, o CPID foi determinado de forma que  
% RiseTime=0,396 e SettlingTime=1,34. Segue:

C=tf([14.547, -14.547*1.62 14.547*0.6881],[1 -1 0],T0);

ma_nova=C*mad;
mf_nova=feedback(ma_nova,1);

%figure
%hold on 
%step(mfd)
%step(mf_nova)
%step(mfd*Kpf)