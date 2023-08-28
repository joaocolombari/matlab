close all;
clc;

format longG
s=tf('s');
options = bodeoptions;
options.FreqUnits = 'Hz'; 
options.XLim = {[20,20000]}; 
options.Grid = 'on'; 

% curva de ganho da equalizacao de gravacao
G1=[(1+3.18e-3*s)*(1+75e-6*s)]/[(1+318e-6*s)];
% curva de ganho da equalizacao de reproducao
G2=[(1+318e-6*s)]/[(1+3.18e-3*s)*(1+75e-6*s)];

figure(1)
hold on; 
bodemag(G1/10,options); bodemag(G2*10,options); 
legend({'Curva de ganho gravação RIAA', ...
    'Curva de ganho reprodução RIAA'}, ...
    'Location','Northeast','FontSize',12); 
title('Equalização RIAA','FontSize',16);
xlabel('Magnitude(dB)','FontSize', 12); 
ylabel('Frequência(Hz)','FontSize', 12);

freq=[20 50.05 70 100 200 500.5 700 1000 2000 2122 5000 7000 10000 20000];

Certo=[19.274 16.941 15.283 13.088 8.219 2.643 1.234 0 -2.589 -2.866 ...
    -8.210 -10.816 -13.734 -19.620];

Result=[62.1829 60.3871 58.9815 57.0132 52.3878 46.8995 45.495 44.2705 ...
    41.7107 41.4358 36.127 33.528 30.6116 24.7237];


diff=[];
diffpc=[];

[~,zero]=(min(abs(Certo - 0)));
zero=Result(zero);

for i=1:length(Result)
    Result(i)=Result(i)-zero;
    diff(i)=abs(Certo(i)-Result(i));
    diffpc(i)=(abs(diff(i)/Certo(i)))*100;
end

figure(2)
hold on; 
bodemag(G2*10,options); scatter(freq,Result,'x');
legend({'Curva de ganho reprodução RIAA', ...
    'Resultados obtidos nos pontos avaliados'}, ...
    'Location','Northeast','FontSize',12); 
title('Resultados Equalização RIAA','FontSize',16);
ylabel('Magnitude','FontSize', 12); 
xlabel('Frequência','FontSize', 12);
 