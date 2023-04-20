% -------------------------------------- % 
%          APDS - Trabalho 04            %
%      Joao Victor Colombari Carlet      %
% -------------------------------------- % 

% Questao 01 %

%% 

close all 
clear all

load('filtros_1.mat');

%% Definicoes 

fs1=15000;
fs2=20000;
fs3=10000;

t1=0:1/fs1:10;         % Vetor tempo 1
t2=0:1/fs2:10;         % Vetor tempo 2
t3=0:1/fs3:10;         % Vetor tempo 3

% Ruido uniforme 
nois1=[-0.5+(1)*rand(length(t1),1)];
nois2=[-0.5+(1)*rand(length(t2),1)];
nois3=[-0.5+(1)*rand(length(t3),1)];

%% Desenvolvimento

% Arquivos sig

% Importando a linha de violao do meu amigo joao luccas
[y,fs]=audioread('/Users/joaovitor/Documents/MATLAB/Monica/APDS_T2/Audio/violao.WAV');

% Gera vetores de 10 segundos

Np=480000;

R=y(1:Np);                    % 10 segundos de track

% Gerando vetor tempo
x=linspace(0, length(y)/(1/48000), length(y));

% Gera vetores de 200 amostras do ruido
N=wgn(Np,1,1);     % Os arquivos possuem o mesmo numero de pontos

% Gera o vetor violao sujo
RN=(0.01*N)+R;

%% TF para auxiliar a visualizacao

% A definicao de k (da DTF) vem da definicao do comando fft. Ja que o comando 
% calcula com X[k] para (k-1), o range de vs q a DTF calcula comeca em 0 e
% vai ate quase 1 (1-1/Np). Ja que o k deve ter Np pontos:

k=(0:1:Np-1);   

% Mas, como disse, esse k so eh util para valores de 0 a Np. Se quiser
% utilizar o vetor para construir algo que mostre a TF, tenho transladar
% com Np/2, encaixando o vetor no primeiro periodo da TF, pondendo entao
% usar para construi-la.

ksh=k-Np/2;

% O v da minha DTFT é um vetor de Np pontos mas que vai de 0 ate 1. Entao
% eh so usar a mesma definicao, ajeitando os valores.

v=k/Np;

% Se eu quiser plotar a DTFT de menos meio a meio DEVO usar o vetor v
% transladado, de maniera a adequa-lo no periodo de interesse.

vsh=ksh/Np;

% Para o vetor de frequencias, acaba ficando como no Trabalho 1. La fiz a
% mesma coisa que vou fazer aqui, arrumando o vetor que vai de -meio a meio
% com o fs para ai sim poder construir minha TF.

f=vsh*fs;

% Para criar a TF vou usar o FFT no meu vetor da x(t)

X_DFT_R=fft(R);
X_DFT_N=fft(N);
X_DFT_RN=fft(RN);

% Isso entao calculou a DTF que ta indo de 0 a 1. Se quiser plotar alguma
% coisa aqui tem que usar o k ou v. 

X_TF_R=(1/fs)*fftshift(X_DFT_R);
X_TF_N=(1/fs)*fftshift(X_DFT_N);
X_TF_RN=(1/fs)*fftshift(X_DFT_RN);

