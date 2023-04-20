close all
clear
clc

% Obtenção de Ktg

%% 1 - Valores medidos

Va = [2.033 3.075 4.129 4.974 6.002 7.216 8.039 9.309];

Vtg = [0.288 0.505 0.703 0.877 1.121 1.403 1.548 1.803];

fe = [3.242 5.46 7.99 9.687 12.44 15.15 16.82 19.96]*10^3;

w = 2*pi/1024*fe;

%% 2 - Regressão linear passando pela origem

mdl = fitlm(w, Vtg, 'intercept', false);
Ktg = mdl.Coefficients.Estimate;
wn = linspace(0, 130);
Vtgn = Ktg*wn;
figure;
hold on;
grid on;
plot(wn, Vtgn)
scatter(w, Vtg, 'x')
xlabel('\omega [rad/s]')
ylabel('V_{tg} [V]')






