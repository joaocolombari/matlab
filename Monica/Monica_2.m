% -------------------------------------- % 
%      AM Modulação e demodulação        %
% -------------------------------------- % 

%%

clear all 
close all 

ts = 1.e-4;
t = -0.04:ts:0.04;
Ta = 0.01;
fc = 500;
B_m = 150;
h = fir1(40,[ B_m*ts ]);

% % MODULANTE PELO triplesinc.m
% m_sig = triplesinc(t,Ta);
% Lfft = 2^ceil(log2(length(t)));

% MODULANTE PELO triangl.m
m_sig = triangl((t+0.01)/0.01)-triangl((t-0.01)/0.01); 
Lm_sig = length(m_sig);
Lfft = 2^ceil(log2(length(t))); 

% TF DO MODULANTE 
M_fre = fftshift(fft(m_sig,Lfft)); 
freqm = (-Lfft/2:Lfft/2-1)/(Lfft*ts);

% AM GERADO ADICIONANDO A PORTADORA AO DSB-SC 
s_am=(1+m_sig).*cos(2*pi*fc*t);
Lfft = 2^ceil(log2(length(t))+1); 

% TF DA AM
S_am = fftshift(fft(s_am,Lfft));
freqs = (-Lfft/2 :Lfft/2-1)/(Lfft*ts); 

% DEMODULADOR:

% RETIFICADOR 
s_dem=s_am.*(s_am>0);      
S_dem=fftshift(fft(s_dem,Lfft));

% PASSA BAIXAS IDEAL CORTANDO EM 150 Hz 
s_rec=filter(h,1,s_dem) ; 
S_rec=fftshift(fft(s_rec,Lfft) ) ;

%% FIGURAS 

% PLOT TRANSIENTE 

Trange=[-0.025 0.025 -2 2] ;
figure (1)

% MENSAGEM
subplot(221) ;
td1=plot(t,m_sig) ;
axis(Trange); 
set(td1,'Linewidth',1.5);
xlabel('{\it t} (sec)'); 
ylabel('{\it m}({\it t})'); 
title('Sinal Modulante');

% MENSAGEM MODULADA
subplot(222) ;
td2=plot(t,s_am) ;
axis(Trange); 
set(td2,'Linewidth',1.5);
xlabel('{\it t} (sec)'); 
ylabel('{\it s}_{\rm DSB}({\it t})') 
title('Sinal AM modulado');

% SINAL AM RETIFICADO SEM PORTADORA
subplot(223);
td3=plot(t,s_dem);
axis(Trange); 
set(td3,'Linewidth',1.5);
xlabel('{\it t} (sec)'); 
ylabel('{\it e}({\it t})') 
title ('Sinal retificado SEM portadora local'); 

% SINAL DETECTADO 
subplot(224); 
td4 = plot (t, s_rec);
Trangelow=[-0.025 0.025 -0.5 1];       
axis(Trangelow); 
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