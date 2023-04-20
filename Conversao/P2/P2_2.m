%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%    Conversão Eletromecanica      %
%      de Energia - Prova 2        %
%   Joao Victor Colombari Carlet   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

close all; clear; clc;  

%% Declarar variaveis: 
 
kaphi=0.8811;
Ia=109.4947;
Ea=219.1960;
Vt=240;
Ra=0.19;

Tmax=kaphi*Ia;
T=(0:1e-3:Tmax);

w=Vt/kaphi-Ra/(kaphi^2)*T;

%% Plota:
 
figure
plot(T, w); grid on;  
xlabel('T[N.m]'); ylabel('w_a[rad/s]');
title('Curva caracteristica de Torque'); 
