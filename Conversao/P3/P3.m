%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%    Conversão Eletromecanica      %
%      de Energia - Prova 3        %
%   Joao Victor Colombari Carlet   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

close all; clear; clc;  

%% Declarar variaveis: 
 
R1=0.12; R2linha=0.10;
X1=0.25; X2linha=X1; Xm=10;
n=6; Vlinha=380; f=60;
Vfase=Vlinha/sqrt(3);

Vth=abs((1i*Xm*Vfase)/(R1+1i*(X1+Xm)));
Zth=1/(1/(1i*Xm)+1/(R1+1i*X1));
Rth=real(Zth);
Xth=imag(Zth);

ns=120*f/n;

s=(0:1e-3:1);
nr=(1-s)*ns;
ws=ns*2*pi/60;

for i=1:1:length(s)
    T(i)=3/ws*((Vth^2)/(((Rth+R2linha/s(i))^2)+((Xth+X2linha)^2))*R2linha/s(i));
end

% Plota:
 
figure(1)
plot(nr, T, 'r'); hold on; 
grid on; hold on;
ylabel('T[N.m]'); xlabel('Nr[RPM]');
title('Curva caracteristica de Torque'); 

% Variando a resistencia do rotor 

R22linha=1.5*R2linha;
R23linha=2*R2linha;

for i=1:1:length(s)
    T2(i)=3/ws*((Vth^2)/(((Rth+R22linha/s(i))^2)+((Xth+X2linha)^2))*R22linha/s(i));
    T3(i)=3/ws*((Vth^2)/(((Rth+R23linha/s(i))^2)+((Xth+X2linha)^2))*R23linha/s(i));
end

% Plota 

figure(2)
plot(nr, T, 'r'); hold on; grid on;
plot(nr, T2, 'b'); plot(nr, T3, 'm');
plot(xlim, [1 1]*300, '--k')               % Horizontal Line 
plot(xlim, [1 1]*600, '--k')               % Horizontal Line 
ylabel('T[N.m]'); xlabel('Nr[RPM]');
title('Curva caracteristica de Torque Mecanico'); 
legend('Curva original','Uma vez e meia a resistencia','Duas vezes a resistencia','Primeira linha de carga em T = 200','Segunda linha de carga em T = 600');
legend('Location','southeast');
