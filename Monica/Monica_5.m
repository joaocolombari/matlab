% -------------------------------------- % 
%      AM Modulação e demodulação        %
%         Com Adicao de Ruido            %
% -------------------------------------- % 

%%

clear all 
close all 

ts = 1.e-4;
t = -0.04:ts:0.04;
Ta = 0.01;

% Portadora com 400Hz:
fc = 400;  
% No enunciado eh pedido modulante de 
% 400Hz, mas dai precisaria de uma por
% tadora muito aguda, complicando a visu
% alizacao. Para isso deliberadamente
% mudei a fc e o sinal modulante (pelo
% triangl).

% Dados do PB ideal da Demodulacao
% (tem que aumentar a ordem desse 
% cara se nao aparece muito 400Hz)
B_m = 150;
h = fir1(55,[B_m*ts]);

% Dados do PB ideal do pre
% vou usar uma largura que com
% porte a portadora. 
% A portadora tem 400Hz, a msg
% tem largura de +-500, entao
% o filtro tem que ser de 900.
% 1200 da e sobra. 
h2 = fir1(55,[1200*ts]);

%% Ruido 

% Faz ruido quase aleatorio do tamanho de t
fs = 1/ts;
nois = randn(length(t),1);

%% Modulacao

% MODULANTE PELO triangl.m
m_sig = triangl((t+0.01)/0.01)-triangl((t-0.01)/0.01); 
Lm_sig = length(m_sig);
Lfft = 2^ceil(log2(length(t))); 

% Rotina para calcular SNR:
% 30dB de SNR quer dizer uma razao 
% de 31.6227 das tensoes de sinal p
% ruido

rms_m = rms(m_sig);
rms_n = rms(nois)

while rms_m/rms_n < 31.6227
    nois=0.99*nois;
    rms_n=rms(nois);
end

% TF DO MODULANTE 
freqm = (-Lfft/2:Lfft/2-1)/(Lfft*ts);

% Limpo
M_fre = fftshift(fft(m_sig,Lfft)); 

% AM GERADO ADICIONANDO A PORTADORA AO DSB-SC 
% O indice de 50% com o 2*cos
Lfft = 2^ceil(log2(length(t))+1); 

% Limpo
s_am=(2+m_sig).*cos(2*pi*fc*t);

% Ruidoso pela Fig 1
for i=1:1:length(t)
    m_sig_nois(i) = m_sig(i)+nois(i); 
end
s_am_nois=(2+m_sig_nois).*cos(2*pi*fc*t);

% TF DO AM

% Limpo
S_am = fftshift(fft(s_am,Lfft));
freqs = (-Lfft/2 :Lfft/2-1)/(Lfft*ts); 

% Ruidoso
S_am_nois = fftshift(fft(s_am_nois,Lfft));

%% PRE FILTRO 

% Para nao criar um vetor a mais 
% (ja sao muitos), vou filtrar no
% comando do demodulador. Em efeito
% eh a mesma coisa, so nao criei um
% vetor x(t) (fig 1).

%% DEMODULADOR:

% RETIFICADOR 

% Limpo
s_dem=filter(h2,1,s_am).*(filter(h2,1,s_am)>0);      
S_dem=fftshift(fft(s_dem,Lfft));

% Ruidoso
s_dem_nois=filter(h2,1,s_am_nois).*(filter(h2,1,s_am_nois)>0);      
S_dem_nois=fftshift(fft(s_dem_nois,Lfft));

% PASSA BAIXAS IDEAL CORTANDO EM 150 Hz 

% Limpo
s_rec=filter(h,1,s_dem); 
S_rec=fftshift(fft(s_rec,Lfft));

% Ruidoso
s_rec_nois=filter(h,1,s_dem_nois); 
S_rec_nois=fftshift(fft(s_rec_nois,Lfft));

%% Erro 

% Calculo do erro da saida 
err_out = immse(s_rec,s_rec_nois)

%% FIGURAS 

%% LIMPO

% PLOT TRANSIENTE 

Trange=[-0.025 0.025 -2 2] ;
figure (1)

% MENSAGEM
subplot(221) ;
td1=plot(t,m_sig);
axis(Trange); 
set(td1,'Linewidth',1.5);
xlabel('{\it t} (sec)'); 
ylabel('{\it m}({\it t})'); 
title('Sinal Modulante');

% MENSAGEM MODULADA
subplot(222) ;
td2=plot(t,s_am) ;
axis(Trange); 
ylim([-4 4])
set(td2,'Linewidth',1.5);
xlabel('{\it t} (sec)'); 
ylabel('{\it s}_{\rm DSB}({\it t})') 
title('Sinal AM modulado');

% SINAL AM RETIFICADO SEM PORTADORA
subplot(223);
td3=plot(t,s_dem);
axis(Trange); 
ylim([-4 4])
set(td3,'Linewidth',1.5);
xlabel('{\it t} (sec)'); 
ylabel('{\it e}({\it t})') 
title ('Sinal retificado SEM portadora local'); 

% SINAL DETECTADO 
subplot(224); 
td4 = plot (t, s_rec);
Trangelow=[-0.025 0.025 -0.5 1];       
axis(Trangelow); 
ylim([0 1.25])
set(td4, 'Linewidth' ,1.5); 
xlabel('{\it t} (sec)'); 
ylabel('{\it m}_d({\it t})') 
title ('Sinal detectado');

% PLOT FFT

Frange = [-700 700 0 200];
figure(2)

% MENSAGEM 
subplot(221); 
fd1 = plot(freqm,abs(M_fre));
axis(Frange); 
set(fd1,'Linewidth',1.5);
xlabel('{\itf} (Hz)');
ylabel('{\itM}({\itf})'); 
title('Espectro do Sinal Modulante');

% MENSAGEM MODULADA
subplot(222);
fd2=plot(freqs,abs(S_am));
axis(Frange); 
set(fd2,'Linewidth',1.5);
xlabel('{\it f} (Hz)'); 
ylabel('{\it S}_{rm AM}({\it f})');
title('Espectro do sinal AM');

% SINAL AM RETIFICADO SEM PORTADORA
subplot(223);
fd3=plot(freqs,abs(S_dem));
axis(Frange); 
set(fd3, 'Linewidth' ,1.5);
xlabel('{\it f} (Hz)'); 
ylabel('{\it E}({\it f}) '); 
title('Sinal Retificado');

% SINAL DETECTADO 
subplot(224);
fd4=plot(freqs,abs(S_rec));
axis(Frange); 
set(fd4,'Linewidth',1.5);
xlabel('{\it f} (Hz)'); 
ylabel('{\it M}_d({\it f})'); 
title('Espectro Recuperado');

%% Ruidoso

% PLOT TRANSIENTE 

Trange=[-0.025 0.025 -2 2] ;
figure (3)

% RUIDO BRANCO
subplot(221) ;
td1=plot(t,nois) ;
axis(Trange); 
set(td1,'Linewidth',1.5);
ylim([-0.3 0.3]);
xlabel('{\it t} (sec)'); 
ylabel('{\it m}({\it t})'); 
title('Ruído Branco');

% MENSAGEM MODULADA
subplot(222) ;
td2=plot(t,s_am_nois);
axis(Trange); 
ylim([-4 4])
set(td2,'Linewidth',1.5);
xlabel('{\it t} (sec)'); 
ylabel('{\it s}_{\rm DSB}({\it t})') 
title('Sinal AM com Ruído modulado');

% SINAL AM RETIFICADO SEM PORTADORA
subplot(223);
td3=plot(t,s_dem_nois);
axis(Trange); 
ylim([-4 4])
set(td3,'Linewidth',1.5);
xlabel('{\it t} (sec)'); 
ylabel('{\it e}({\it t})') 
title ('Sinal com Ruído retificado '); 

% SINAL DETECTADO 
subplot(224); 
td4 = plot (t, s_rec_nois);
Trangelow=[-0.025 0.025 -0.5 1];       
axis(Trangelow); 
ylim([0 1.25])
set(td4, 'Linewidth' ,1.5); 
xlabel('{\it t} (sec)'); 
ylabel('{\it m}_d({\it t})') 
title ('Sinal com Ruído detectado');

% PLOT FFT

Frange = [-700 700 0 200];
figure(4)

% MENSAGEM MODULADA
subplot(211);
fd2=plot(freqs,abs(S_am_nois));
axis(Frange); 
set(fd2,'Linewidth',1.5);
xlabel('{\it f} (Hz)'); 
ylabel('{\it S}_{rm AM}({\it f})');
title('Espectro do sinal AM com Ruído');

% SINAL AM RETIFICADO SEM PORTADORA
subplot(223);
fd3=plot(freqs,abs(S_dem_nois));
axis(Frange); 
set(fd3, 'Linewidth' ,1.5);
xlabel('{\it f} (Hz)'); 
ylabel('{\it E}({\it f}) '); 
title('Sinal com Ruído Retificado');

% SINAL DETECTADO 
subplot(224);
fd4=plot(freqs,abs(S_rec_nois));
axis(Frange); 
set(fd4,'Linewidth',1.5);
xlabel('{\it f} (Hz)'); 
ylabel('{\it M}_d({\it f})'); 
title('Espectro Ruidoso Recuperado');

%% Comparacao saidas na mesma figura

% SINAL ENVIADO

figure(5)
plot(t, m_sig,'b',t, m_sig_nois,'r');
ylim([-1.5 1.5]);
xlabel('{\it t} (sec)'); 
ylabel('{\it m}_d({\it t})') 
title ('Sinal modulador: Comparação');

% SINAL DETECTADO 

figure(6)
plot(t, s_rec,'b',t, s_rec_nois,'r');
Trangelow=[-0.025 0.025 -0.5 1];       
axis(Trangelow); 
ylim([0 1.25])
set(td4, 'Linewidth' ,1.5); 
xlabel('{\it t} (sec)'); 
ylabel('{\it m}_d({\it t})') 
title ('Sinal detectado: Comparação');