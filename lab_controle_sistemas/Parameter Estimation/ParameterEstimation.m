close all; clear all;
clc;

format longG
%% Aquisicao dos dados

ch1Table = readtable(['F0001CH1.csv']) ; % Corrente
ch2Table = readtable(['F0001CH2.csv']) ; % Velocidade
Ts = 1e-4; % Sample Time , presente no arquivo.csv importado do osciloscopio
Atenuacao = 10;

%% Obtenção dos valores de corrente e velocidade ( não tratados )

ValorCorrente = table2array(ch1Table(1:end,5));
TempoCorrente = table2array(ch1Table(1:end,4));
ValorVelocidade = table2array(ch2Table(1:end,5));
TempoVelocidade = TempoCorrente;

% Tratando vetores
Ktg = 0.1504; 
Rext = 0.47; % Resitor utilizado para medir corrente
Vstep = 12.28; % Degrau de tensão aplicado na entrada .
corrente = Atenuacao*ValorCorrente/Rext; %Vrext = Rext*Ia
velocidade = Atenuacao*ValorVelocidade/Ktg; %V(t)=Ktg*w

% Tratando vetores
Ia = corrente(193:end);
Omega = velocidade(193:end);
Va = [zeros(0,1); Vstep*ones(length(Omega),1)];

% Adequa tempo das amostras
tempo = linspace(Ts,Ts*size(Omega,1),size(Omega,1));
tempo = tempo';
Wmed =[tempo Omega]; % Velocidade medida do degrau rad/s
Vamed =[tempo Va]; % Tensao de armadura Volts
Iamed =[tempo Ia]; % Corrente de armadura Volts
  
%% Parametros iniciais

Ra = 0.1501; % Resistencia de armadura [Ohm]
La = 0.000150; % Indutancia de armadura [H]
K = 0.087; % Kt=Ke para este motor : Constante de torque [N-m/A] ou Constante f.c.e.m [V-s/rad]
J = 0.00050804; % Momento de inercia [N-m-s^2/rad]
B = 0.0006; % Coeficiente de atrito viscoso [N-m-s/rad]
Kt = K;
Ke = K;
% run ('SimulacaoMotorCCr2016a') ;
%% Modelo do motor CC (FT 2ª ordem - Velocidade angular vs. Va)

s = tf('s');
Gm = @(Kt,Ke,Ra,La,J,B,s) Kt/(La*J*s^2+(Ra*J+La*B)*s+(Ra*B+Ke*Kt));
Gm0 = Gm(Kt,Ke,Ra,La,J,B,s);

%% Modelo do motor CC obtido com o Paramater Estimation 

B1 = 0.00045348;
J1 = 0.00015263;
K1 = 0.072987;
La1 = 4.2915e-05;
Ra1 = 0.71218;
Kt1 = K1;
Ke1 = K1;

Gm1 = @(Kt1,Ke1,Ra1,La1,J1,B1,s) Kt1/(La1*J1*s^2+(Ra1*J1+La1*B1)*s+(Ra1*B1+Ke1*Kt1));
Gm1 = Gm(Kt1,Ke1,Ra1,La1,J1,B1,s); 

[num,den]=tfdata(Gm1)

%% Comparacao chute, modelo e valor real 

figure
plot(lsim(Gm0,Va,tempo)); hold on;
plot(lsim(Gm1,Va,tempo)); 
plot(Omega); hold off;
legend('Modelagem com Chute inicial','Modelagem com Parameter Estimation','Valor obtido em bancada');
title('Comparacao modelos e experimento')


%% Dados das regressoes 

kPWM=1.2341;
ktg=0.0148;
% kat=2.8868; esse eh o nosso!!!!

kat=3.4272;

kat=kat*ktg;

H=tf(kat,1);
F=tf(8,1);
G=Gm1*kPWM;

% rltool


