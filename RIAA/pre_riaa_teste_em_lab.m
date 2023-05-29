close all;
clc;

%% Setting plot options 

format longG
s=tf('s');
options = bodeoptions;
options.FreqUnits = 'Hz'; 
options.XLim = {[20,20000]}; 
options.Grid = 'on'; 

%% Computing transfer function

% curva de ganho da equalizacao de reproducao
G1=[(1+318e-6*s)]/[(1+3.18e-3*s)*(1+75e-6*s)];

%% Processing lab data 

% Defining frequency points 
freq=[20 50.05 70 100 200 500.5 700 1000 2000 2122 5000 7000 10000 20000];
% Measured data - channel 1 (mVrms for input and Vrms for output)
input_c1=[7.6 7.8 7.8 7.6 7.6 7.6 7.6 7.6 7.2 7.2 7.4 7.4 7.2 7.2];
output_c1=[4.88 4.48 4 3.04 1.72 0.92 0.78 0.68 0.52 0.5 0.28 0.216 0.136 ...
    0.068];
% Measured data - channel 2 (mVrms for input and Vrms for output)
input_c2=[6.6 6.6 6.6 6.6 6.8 6.8 6.8 6.8 6.8 6.8 6.8 6.8 6.8 6.8];
output_c2=[5.8 5.4 4.8 3.6 2.08 1.2 0.92 0.84 0.64 0.6 0.32 0.232 0.168 ... 
    0.072];
% Computing gain - channel 1
gain_c1=[];
for i=1:1:length(freq)
    gain_c1(i)=20*log10(1e3*output_c1(i)/input_c1(i));
end
gain_c1_norm=gain_c1-gain_c1(8);
% Computing gain - channel 2
gain_c2=[];
for i=1:1:length(freq)
    gain_c2(i)=20*log10(1e3*output_c2(i)/input_c2(i));
end
gain_c2_norm=gain_c2-gain_c2(8);


%% Ploting results and comparing with ideal RIAA curve

figure(1)
hold on; 
bodemag(G1*10,options); scatter(freq,gain_c1_norm,'x');
scatter(freq,gain_c2_norm,'o');
legend({'Curva de ganho reprodução RIAA', ...
    'Resultados obtidos - Canal 1', ...
    'Resultados obtidos - Canal 2'}, ...
    'Location','Northeast','FontSize',12); 
title('Resultados Equalização RIAA','FontSize',16);
ylabel('Magnitude(dB)','FontSize', 12); 
xlabel('Frequência(Hz)','FontSize', 12);

