% Controle Digital
% Atividade pr»-lab 
% N?USP: 10748455 - Pedro Arthur Galv?o Pizarro

% Defini¡?o do sistema em uso 
a1 = (84 + 55)/10;
a0 = (84*55)/100;
b0 = (84*55)/10;

num = [0 b0];
dem = [1 +a1 +a0];

% Sistema do Pr»-Lab 1
Gp_s = tf(num,dem);

% Taxa de amostragem igual a do PID, assim como os polos 
% Polos dominantes PID: 0.87841 - 0.076133i   e   0.87841 + 0.076133i
T0 = 0.02;

% Amplitude do step
R0 = 7.2;

% Matrizes A,B,C,D reais obtidas do PreLab1
A = [-5.5 0; 1 -8.40];
B = [462; 0];
C = [0 1];
D = 0;

% Discretizando as matrizes A,B.
[F, H, Cd, Dd] = c2dm(A,B,C,D,T0);

% Determinando os polos discretos com base nos polos contÃnuos desejados
Dinamica = [0.9089 + 0.0841*i 0.9089 - 0.0841*i]; % Polos que ditam a din?mica do processo realimentado

% Obtendo K de alimenta¡?o discreto
K = place(F, H, Dinamica);

% Representa¡?o do sistema usando espa¡o de estados com realimenta¡? k. (FTMF)
EE = ss(F-H*K ,H, Cd, Dd, T0);

[y t x] = step(R0*EE)

% A¡?o de controle
u = R0 - K*x';

%Plots
% Resposta ao degrau
figure(1)
stairs(t,y)
title('Resposta ao degrau (R0) sem pr» filtro')

% A¡?o de controle
figure(2)
stairs(t,u)
title('A¡?o de controle ao degrau (R0) sem pr» filtro')

%% Implementa¡?o da FTMF no Espa¡o de Estados com pr»-filtro
% Calculando Kpf
Kpf = 1/dcgain(EE);

[y_k t_k x_k] = step(R0*Kpf*EE)

u_k = R0 - K*x_k';

%Plots
% Resposta ao degrau
figure(3)
stairs(t_k,y_k)
title('Resposta ao degrau (R0) com pr» filtro')

% A¡?o de controle
figure(4)
stairs(t_k,u_k)
title('A¡?o de controle ao degrau (R0) com pr» filtro')