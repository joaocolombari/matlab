close all;
clc;
%% Aquisicao dos dados

ch1Table = readtable(['F0000CH2.csv']) ; % Corrente
ch2Table = readtable(['F0000CH1.csv']) ; % Velocidade
Ts = 4e-4; % Sample Time , presente no arquivo.csv importado do osciloscopio
Atenuacao = 10;

%% Obtenção dos valores de corrente e velocidade ( não tratados )

ValorCorrente = table2array(ch1Table(1:end,5));
TempoCorrente = table2array(ch1Table(1:end,4));
ValorVelocidade = table2array(ch2Table(1:end,5));
TempoVelocidade = TempoCorrente;

% Tratando vetores
Ktg = 0.014836198290766; 
Rext = 0.47; % Resitor utilizado para medir corrente
Vstep = 12.273; % Degrau de tensão aplicado na entrada .
corrente = Atenuacao*ValorCorrente/Rext; %Vrext = Rext*Ia
velocidade = Atenuacao*ValorVelocidade/Ktg; %V(t)=Ktg*w

% Tratando vetores
Ia = corrente(1372:end);
Omega = velocidade(1369:end);
Va = [zeros(0,1); Vstep*ones(length(Omega),1)];

% Adequa tempo das amostras
tempoV = linspace(Ts,Ts*size(Omega,1),size(Omega,1));
tempoI = linspace(Ts,Ts*size(Ia,1),size(Ia,1));
tempoV = tempoV';
tempoI = tempoI';
Wmed =[tempoV Omega]; % Velocidade medida do degrau rad/s
Vamed =[tempoV Va]; % Tensao de armadura Volts
Iamed =[tempoI Ia]; % Corrente de armadura Volts

%% Parametros iniciais

Ra = 2.47; % Resistencia de armadura [Ohm]
La = 0.5e-3; % Indutancia de armadura [H]
K = 0.0673; % Kt=Ke para este motor : Constante de torque [N-m/A] ou Constante f.c.e.m [V-s/rad]
J = 1.1e-5; % Momento de inercia [N-m-s^2/rad]
B = 1.8e-3; % Coeficiente de atrito viscoso [N-m-s/rad]
Kt = K;
Ke = K;
%run ('SimulacaoMotorCCr2016a') ;
%% Modelo do motor CC (FT 2ª ordem - Velocidade angular vs. Va)

s = tf('s');
Gm = @(Kt,Ke,Ra,La,J,B,s) Kt/(La*J*s^2+(Ra*J+La*B)*s+(Ra*B+Ke*Kt));
Gm0 = Gm(Kt,Ke,Ra,La,J,B,s);


