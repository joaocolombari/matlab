close all
clear
clc

%% 1 - Carregar conteúdo do osciloscópio

load workspace_conteudo_osciloscopio

%% 2 - Sample time

ts = 4e-4;

%% 3 - Início do degrau 

amst_degrau = 1372;

%% 4 - Geração do sinal de entrada

Entrada_v = [zeros(amst_degrau,1); 12.273*ones(length(v_ch1) - amst_degrau,1)];
Entrada_i = [zeros(amst_degrau,1); 12.273*ones(length(i_ch2) - amst_degrau,1)];

% Figuras

%figure(1)
%plot(t_ch1,v_ch1,t_ch2,i_ch2)

%figure(2)
%plot(t_ch1,v_ch1,t_ch1,Entrada)

%% 5 - Adequação dos sinais medidos

Ktg = 0.014836198290766;
Rext = 0.47;

velocidade = v_ch1/Ktg;
corrente = i_ch2/Rext;

close all

%figure(1)
%plot(t_ch1,v_ch1,t_ch2,i_ch2)

%figure(1)
%plot(t_ch1,velocidade,t_ch1,Entrada_v)

%figure(2)
%plot(t_ch1,velocidade,t_ch1,Entrada_v)

%% 6 - Vetor temporal

tempo_v = linspace(ts,ts*size(velocidade,1),size(velocidade,1));

tempo_i = linspace(ts,ts*size(corrente,1),size(corrente,1));

figure(1)
plot(tempo_v,velocidade)
xlabel('Tempo [s]')
ylabel('\omega(t) [rad/s]')


figure(2)
plot(tempo_i,corrente)
xlabel('Tempo [s]')
ylabel('i_a(t) [A]')

%% 7 - Funções de Transferência

FTv = load('G4');

FTi = load('G2');

FTv = FTv.G4;

FTi = FTi.G2;

%% 8 - Plots das FTs

tiv = 0.5488;
tii = 0.5476;

tfv = 1;
tfi = 0.9956;

close 1 2

tempo_vnovo = tiv:ts:tfv;

tempo_inovo = tii:ts:tfi;

aux1 = (0:(length(tempo_vnovo) - 1))*ts;
aux2 = (0:(length(tempo_inovo) - 1))*ts;

velocidade_novo = velocidade(1372:2500);

corrente_novo = corrente(1369:2489);

opt = stepDataOptions;
opt.StepAmplitude = 12.273;

a = step(FTv,aux1,opt)';
b = step(FTi,aux2,opt)';

figure(3)
plot(tempo_vnovo,velocidade_novo)
hold on
plot(tempo_vnovo,a)
xlabel('Tempo [s]')
ylabel('\omega(t) [rad/s]')
legend('Medida', 'Calculada')

figure(4)
plot(tempo_inovo,corrente_novo)
hold on
plot(tempo_inovo,b)
xlabel('Tempo [s]')
ylabel('i_a(t) [A]')
legend('Medida', 'Calculada')



return
%% 8 - Plot das FTs

opt = stepDataOptions;
opt.StepAmplitude = 12.273;

figure(3)
step(G4,opt)
%hold on
%plot()

figure(4)
step(G2,opt)


