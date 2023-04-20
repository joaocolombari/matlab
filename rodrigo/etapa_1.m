clear all
options=timeoptions;
options.Grid='on';

% definicao da matriz A
A0 = [0          376.9911    0           0       ;
     -0.15685    0           -0.0787     4       ;
     -0.16725    0           -0.46296    0.166667;
     1572.825    0           -5416.98    -100    ];

% Definicao da matriz B
B = [0          0           0           10000   ]';

% definicao das condicoes iniciais
x0 = [0 0 0 0.1]';

% matriz deltaA
DA = A0;
DA(1,2) = 0;
DA(4,4) = 0;
DA = DA * 0.05 .* (rand(size(DA, 1), size(DA, 2)) * 2 - 1);

% A + deltaA
A = A0 + DA;

% Definicao do funcional LQR com chute
% A eh 4x4 e B eh $x1. Como Q e R sao
% diagonais, Q deve ser 4x4 e R 1x1

Q = [1 0 0 0;
     0 1 0 0;
     0 0 1 0;
     0 0 0 1e-5];

R = [1];

% Determinacao do ganho otimo para o modelo nominal 
[K, P, E]=lqr(A,B,Q,R);

% Definicao do sistema com ss para a integracao
C = [1 0 0 0;
     0 1 0 0;
     0 0 1 0;
     0 0 0 1];
D = [0;
     0;
     0;
     0];
 
t=0:1e-3:0.5;
sys=ss((A-B*K),B,C,D);
[y,t,x]=initial(sys,x0,t);
x=x';

% Calculo do funcional J
u = -K*x;

    % Com integracao numerica trapezoidal
    JD = x'*Q*x+u'*R*u;
    J = zeros(1,length(JD));
    for i=1:(length(JD))
        J(1,i) = JD(i,i);
    end
    J1=trapz(t,J);

    % Com a equacao
    J2=x0'*P*x0;
   
% Gerando o grafico da resposta dada a condicao x0
figure(1); 

subplot(4,1,1); plotx1=plot(t,x(1,:)); title('Variavel x1');
ylabel('x'); xlabel('tempo'); set(plotx1,'Linewidth',1.5); grid on;

subplot(4,1,2); plotx2=plot(t,x(2,:)); title('Variavel x2');
ylabel('x'); xlabel('tempo'); set(plotx2,'Linewidth',1.5); grid on;

subplot(4,1,3); plotx3=plot(t,x(3,:)); title('Variavel x3');
ylabel('x'); xlabel('tempo'); set(plotx3,'Linewidth',1.5); grid on;

subplot(4,1,4); plotx4=plot(t,x(4,:)); title('Variavel x4');
ylabel('x'); xlabel('tempo'); set(plotx4,'Linewidth',1.5); grid on;

% Calculando os 100 (bastate neh) funcionais 

J1n=[];
J2n=[];
n=[];

for i=1:1:100
    DA = A0;
    DA(1,2) = 0;
    DA(4,4) = 0;
    DA = DA * 0.05 .* (rand(size(DA, 1), size(DA, 2)) * 2 - 1);
    An = A0 + DA;
    
    [Kn, Pn, En]=lqr(An,B,Q,R);
    
    sysn=ss((An-B*K),B,C,D);
    [yn,t,xn]=initial(sysn,x0,t);
    xn=xn';
    
    un=-K*xn;
    
    JDn = xn'*Q*xn+un'*R*un;
    Jn = zeros(1,length(JDn));
    for a=1:(length(JDn))
        Jn(1,a) = JDn(a,a);
    end
    J1n=[J1n trapz(t,Jn)];
    J2n=[J2n x0'*Pn*x0];
    
    n=[n i];
end

% Plotando os resultados
figure(2);

subplot(2,1,1); hold on; grid on;
scatter(n,J1n); plotJ1n=plot(n,ones(size(n))*J1);
title('Funcional J por integração - comparação com o inicial');
ylabel('Funcional'); xlabel('Iteração'); set(plotJ1n,'Linewidth',1.5);

subplot(2,1,2); hold on; grid on;
scatter(n,J2n); plotJ2n=plot(n,ones(size(n))*J2);
title('Funcional J pela equação - comparação com o inicial');
ylabel('Funcional'); xlabel('Iteração'); set(plotJ2n,'Linewidth',1.5);
