%clear all;
close all;
clc;   
%% Aquisicao dos dados

ch1Table = readtable(['TEK0001.csv']) ; % Corrente
ch2Table = readtable(['TEK0002.csv']) ; % Velocidade
Ts = 1e-4; % Sample Time , presente no arquivo.csv importado do osciloscopio
Atenuacao = 1;

%% Obtenção dos valores de corrente e velocidade ( não tratados )

ValorCorrente = table2array(ch1Table(1:end,5));
ValorVelocidade = table2array(ch2Table(1:end,5));
TempoVelocidade = table2array(ch2Table(1:end,4));
TempoCorrente = TempoVelocidade;
%%
% Tratando vetores
Ktg = 0.1504; 
Rext = 0.68; % Resistor utilizado para medir corrente
Vstep = 12.28; % Degrau de tensão aplicado na entrada .
corrente = Atenuacao*ValorCorrente/Rext; %Vrext = Rext*Ia
velocidade = Atenuacao*ValorVelocidade/Ktg; %V(t)=Ktg*w

% Tratando vetores
Ia = corrente(317:end);
Omega = velocidade(317:end);
Va = [zeros(0,1); Vstep*ones(length(Omega),1)];

%%
% Plotando as variáveis

tempo = linspace(Ts,Ts*size(Omega,1),size(Omega,1));
figure
subplot(2,1,1)
plot(tempo,Omega, 'r')
axis([0 0.2 0 150])
grid on
xlabel('Tempo (s)')
ylabel('\omega (rad/s)')

subplot(2,1,2)
plot(tempo, Ia, 'b')
axis([0 0.2 0 3])
grid on
xlabel('Tempo (s)')
ylabel('I_a (A)')