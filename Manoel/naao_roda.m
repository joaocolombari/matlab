%%%%%%%%%%%%%%%%%%%%
% pre lab manoel   %
%%%%%%%%%%%%%%%%%%%%

% Definir minha funcao normalmente:

Gp1=tf([1],[1 4.5]);
Gp2=tf([1],[1 0.2]);

Gp=Gp1*Gp2*18

%rlocus(Gp)

% Aqui ja deixo o comando rlocus(a) indicado. Determinei q0, segue:

q0=0.577;

% Definicao resposta alvo:

Gp_a=feedback(q0*Gp,1)
figure
step(Gp_a)

% Agora, encontrar a frequencia para o T0:

infor=stepinfo(Gp_a);
%figure 
%bode(Gp_a)

% Sei que com o Risetime/10 a função adere melhor, vou usa-lo. 
% Arredondar na terceira casa:

t0 = 0.1*infor.RiseTime
T0 = round(t0,3)

% Escolher R0 e arredondar para uma casa decimal:

Yss=23.9;
r0=0.7*Yss;
R0=round(r0,1)

% informações para o Simulink

Umax=10;
atraso=infor.SettlingTime;
ganho=0.01027*infor.SettlingMax;
b0=18;

%%%%%%%

Gpa_d=c2d(Gp,T0);
Gpf_d=c2d(Gp_a,T0);

%rltool(Gpa_d)

% Rodado o comando, o CPID foi determinado de forma que  
% RiseTime=0,815 e SettlingTime=1,89. Segue:

C=tf([0.4 -0.977*0.4],[1 -1],T0);
q0c=0.4;
q1c=0.977;

GpPIa=series(C,Gpa_d);

% para a saida:
GpPIf=feedback(GpPIa,1);
fy=GpPIf;

% para u:
fu=feedback(C,Gpa_d)

% para o erro:
SP=R0;
[y,t]=step(SP*Gpf_d);
sserror=abs(SP-y(end));
fe=1-fy

figure
hold on 
grid on
step(R0*fy,'r')
step(R0*fu,'y')
step(R0*fe,'b')
legend({'fy','fu','fe'})
