%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%    Conversão Eletromecanica      %
%     de Energia Prova 1           %
%   Joao Victor Colombari Carlet   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

close all; clear; clc; 

%% Declarar variaveis: 

syms t

delta=30;%graus
ws=377;%rad

theta=ws*t+delta;%wm=ws
is=2*cos(ws*t);
ir=2;%CC no rotor
Lsr=0.2*cos(theta);

T=is*ir*diff(Lsr);

%% Plota:

figure 
title('Torque'); hold on; grid on; 
fplot(T); xlim([0 0.1]); ylim([0 300])
xlabel('t[s]'); ylabel('T[N.m]'); 