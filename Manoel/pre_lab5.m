%%%%%%%%%%
% JVCC
%%%%%%%%%%
% Definir minha funcao normalmente:

Gp1=tf([1],[1 4.5]);
Gp2=tf([1],[1 0.2]);

b0=18;
ma=Gp1*Gp2*b0
mf=feedback(ma,1);

% Informa¡?es do PI + informa¡?es da perturba¡?o

Yss=23.9;
Umax=10;
r0=0.7*Yss;
R0=round(r0,1);
infor=stepinfo(mf);
atraso=infor.SettlingTime;
ganho=0.01027*infor.SettlingMax;
T0=0.063

% Definindo o espa¡o de estados e discretizando-o 

A=[-4.5 0; 1 -0.2];
B=[18; 0];
C=[0 1];
D=[0];

sysss=ss(A,B,C,D);

[Ad, Bd, Cd, Dd] = c2dm(A,B,C,D,T0);

% Determinando o K
   
polos = [0.8998 + 0.2701*j 0.8998 - 0.2701*j];

K = place(Ad, Bd, polos);

% Fechando a malha

sysss2 = ss(Ad-Bd*K, Bd, Cd, Dd, T0);

[y t x] = step(R0*sysss2);

u = R0 - K*x';

% Definindo o Kpf e ajustando para aderir ?

Kpfs = 0.93*1/dcgain(sysss2);

[y2 t2 x2] = step(R0*Kpfs*sysss2);

u2 = R0 - K*x2';

% Plotando os resultados 

figure(1)
hold on
stairs(t,y,'r')
stairs(t,u,'b')
title('Sem Kpf')
legend({'Step','Controle'})

figure(2)
hold on
stairs(t2,y2,'r')
stairs(t2,u2,'b')
title('Com Kpf')
legend({'Step','Controle'})
