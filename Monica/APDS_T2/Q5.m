% -------------------------------------- % 
%          APDS - Trabalho 02            %
%      Joao Victor Colombari Carlet      %
% -------------------------------------- % 

% Questao 05 %

%% 

close all 
clear all

%% Desenvolvimento

% Importando
[y,ts]=audioread('/Users/joaovitor/Documents/MATLAB/Monica/APDS_T2/Audio/violao.WAV');

% Gerando vetor tempo
x=linspace(0, length(y)/ts, length(y));

% Gera vetores de 1000 amostras 
R1=y((length(y)-999):length(y)); % Fim da track
R2=y(1:1000);                    % Inicio da track  

% Determina a autocorrelacao de ambos
ACFR1=xcorr(R1,'biased');
ACFR2=xcorr(R2,'biased');

% Criando variavel tau
tau=-(length(ACFR1)-1)/2:1:(length(ACFR1)-1)/2;

% determina as potencias
P1=ACFR1((length(ACFR1)-1)/2+1);
P2=ACFR2((length(ACFR2)-1)/2+1);

% Calcula SNR
SNR=P2/P1-1;
SNRdb=10*log10(SNR);

% Plot
figure(1)
subplot(2,1,1)
plot(tau,ACFR1); title('Autocorrelacao Parte Quieta');
ylabel('Correlacao'); xlabel('Defasagem Tau');
ylim([-1e-3 1.5e-3]);
%%%%%
subplot(2,1,2)
plot(tau,ACFR2); 
title('Autocorrelacao Musica'); 
ylabel('Correlacao'); xlabel('Defasagem Tau');
ylim([-1e-3 1.5e-3]);
