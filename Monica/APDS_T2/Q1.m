% -------------------------------------- % 
%          APDS - Trabalho 02            %
%      Joao Victor Colombari Carlet      %
% -------------------------------------- % 

% Questao 01 %

%% 

close all 
clear all

%% Definicoes 

ts=1.e-6;                       % Tamanho do passo 
t=-1.0:ts:1.0;                  % Vetor tempo 

% Ruido 

% Faz ruido quase aleatorio do tamanho de t
% de -1 a 1
nois=[-1+(2)*rand(length(t),1)];

%% Desenvolvimento

% Gera 10 vetores de 200 amostras do ruido
R1=nois(1:200);R2=nois(301:500);
R3=nois(701:900);R4=nois(1101:1300);
R5=nois(1801:2000);R6=nois(2501:2700);
R7=nois(2901:3100);R8=nois(3901:4100);
R9=nois(4501:4700);R10=nois(6801:7000);

% Estimativa da funcao de autocorrelação do ruido
ACF1=xcorr(R1,'biased');ACF2=xcorr(R2,'biased');
ACF3=xcorr(R3,'biased');ACF4=xcorr(R4,'biased');
ACF5=xcorr(R5,'biased');ACF6=xcorr(R6,'biased');
ACF7=xcorr(R7,'biased');ACF8=xcorr(R8,'biased');
ACF9=xcorr(R9,'biased');ACF10=xcorr(R10,'biased');

% Funcao de autocorrelacao media
MACF=(ACF1+ACF2+ACF3+ACF4+ACF5+ACF6+ACF7+ACF8+ACF9+ACF10)/10;

% Criando variavel tau
tau=-(length(MACF)-1)/2:1:(length(MACF)-1)/2;
      
% Plot ACF1 e MACF
figure(1)
title('Funcao de Autocorrelacao'); grid on; hold on
ylabel('Autocorrelacao'); xlabel(' \tau');
plot(tau,ACF1); plot(tau,MACF); 
legend('Autocorrelacao Amostra 1','Autocorrelacao Media');

% Acrescentando Nivel DC
% nro usp 5274502, DC=2/10=0.2
DC=0.2;

nois=nois+DC;

R1=nois(1:200);R2=nois(301:500);
R3=nois(701:900);R4=nois(1101:1300);
R5=nois(1801:2000);R6=nois(2501:2700);
R7=nois(2901:3100);R8=nois(3901:4100);
R9=nois(4501:4700);R10=nois(6801:7000);

ACF1=xcorr(R1,'biased');ACF2=xcorr(R2,'biased');
ACF3=xcorr(R3,'biased');ACF4=xcorr(R4,'biased');
ACF5=xcorr(R5,'biased');ACF6=xcorr(R6,'biased');
ACF7=xcorr(R7,'biased');ACF8=xcorr(R8,'biased');
ACF9=xcorr(R9,'biased');ACF10=xcorr(R10,'biased');

MACF=(ACF1+ACF2+ACF3+ACF4+ACF5+ACF6+ACF7+ACF8+ACF9+ACF10)/10;

% Plot ACF1 e MACF + DC
figure(2)
title('Funcao de Autocorrelacao com Nivel DC'); 
grid on; hold on
ylabel('Autocorrelacao'); xlabel('\tau');
plot(tau,ACF1); plot(tau,MACF); 
legend('Autocorrelacao Amostra 1','Autocorrelacao Media');
