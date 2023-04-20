% Definir minha funcao normalmente:

Gp1=tf([1],[1 4.5]);
Gp2=tf([1],[1 0.2]);

b0=18;
ma=Gp1*Gp2*b0
mf=feedback(ma,1);

% Informações (atenção para o T0 que garante o q0 no intervalo ideal)

Kpf = 1.0436;
Yss=23.9;
Umax=10;
r0=0.7*Yss;
R0=round(r0,1);
infor=stepinfo(mf);
t0 = 0.1*infor.RiseTime;
%T0 = 1.6*round(t0,3);
T0=0.0819
% Discretizando com C2D

mad=c2d(ma,T0);
mfd=c2d(mf,T0);

% Determinando q0

b1=mad.num{1}(2);
%b1=0.01354;
b2=mad.num{1}(3);
%b2=0.01271;

a1=mad.den{1}(2);
%a1=-1.827;
a2=mad.den{1}(3);
%a2=0.8286;

q0=1/sum(mad.num{1});

q1=q0*a1;
q2=q0*a2;
p1=q0*b1;
p2=q0*b2;

GDB=tf([q0 q1 q2],[1 -p1 -p2],T0);

% Fechando o processo 

ma_nova=series(GDB,mad);
mf_nova=feedback(ma_nova,1);

% Determinando os F pedidos 

% para a saida:
fy=mf_nova

% para u:
fu=feedback(GDB,mad)

% para o erro:
SP=R0;
[y,t]=step(SP*mf_nova);
sserror=abs(SP-y(end));
fe=feedback(1,ma_nova)

% Figura

figure
hold on 
grid on
step(fy,'r')
step(fu,'y')
step(fe,'b')
legend({'fy','fu','fe'})


