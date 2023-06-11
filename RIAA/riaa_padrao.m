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

Result=[60.3771 58.1824 56.5536 54.3809 49.533 43.9623 42.5428 41.2974 ... 
    38.6686 38.3866 32.9949 30.3797 27.4537 21.5592];

% Result=[76.3313 73.9022 72.1889 69.9469 65.0355 59.47 58.0645 56.8372 ...
%     54.252 53.9741 48.6263 46.0188 43.0962 37.1963];

% Result=[76.3499 73.9664 72.272 70.0444 65.1372 59.5317 58.1063 56.862...
%     54.2592 53.9805 48.6274 46.0194 43.0965 37.1964];

% Result=[76.386 73.960 72.254 70.019 65.109 59.521 58.105 56.8679 54.272 53.994 ... 
%     48.642 46.034 43.111 37.211];

% Result=[76.475 74.409 72.860 70.759 65.991 60.464 59.062 57.842 55.296 ...
%     55.026 49.727 47.131 44.214 38.319];


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
xlabel('Magnitude(dB)','FontSize', 12); 
ylabel('Frequência(Hz)','FontSize', 12);
 