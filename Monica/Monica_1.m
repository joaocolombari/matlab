% -------------------------------------- % 
%    DSB-SC Modulação e demodulação      %
% -------------------------------------- % 

%%

close all 
clear all 

% ts = 1.e-4;
% t = -0.04:ts:0.04;
% Ta = 0.01;
% 
% % MODULANTE PELO triplesinc.m
% m_sig = triplesinc(t,Ta);
% Lfft = 2^ceil(log2(length(t)));
% 
% % TF DO MODULANTE
% M_fre = fftshift(fft(m_sig,Lfft));
% freqm= (-Lfft/2 :Lfft/2-1)/(Lfft*ts);
% 
% % MODULANDO O SINAL
% s_dsb = m_sig.*cos(2*pi*500*t);
% Lfft = 2^ceil(log2(length(t))+1);
% 
% % TF DO MODULADO 
% S_dsb=fftshift(fft(s_dsb,Lfft));
% freqs = (-Lfft/2:Lfft/2-1)/(Lfft*ts);
% 
% %% PLOTS
% 
% % PLOT TRANSIENTE 
% Trange=[-0.03 0.03 -2 2];
% figure(1)
% 
% subplot(221);
% tdl=plot(t,m_sig); 
% axis(Trange); 
% set(tdl,'Linewidth',2);
% xlabel('{\it t} (sec)'); 
% ylabel('{\it m}({\it t})') 
% title('Sinal Modulante no Tempo') 
% 
% subplot(223);
% td2=plot(t,s_dsb);
% axis(Trange); 
% set(td2,'Linewidth',2);
% xlabel('{\it t} (sec)'); 
% ylabel('{\it s}_{\rm DSB}({\it t})')
% title('Sinal Modulado')
% 
% % PLOT FFT 
% Frange = [-600 600 0 200];
% subplot(222);
% 
% fd=plot(freqm,abs(M_fre));
% axis(Frange); 
% set(fd,'Linewidth',2);
% xlabel('{\it f} (Hz)'); 
% ylabel('{\it M}({\it f})') 
% title('Sinal Modulante na Frequencia') 
% 
% subplot(224);
% fd2=plot(freqs,abs(S_dsb));
% axis(Frange); 
% set(fd2,'Linewidth',2);
% xlabel('{\it f} (Hz)'); 
% ylabel('{\it S}_{rm DSB}({\it f}) ')
% title('Sinal Modulado na Frequencia')

%%

% Essa aqui é a triangular 

ts = 1.e-4;              
t = -0.04:ts:0.04;       
Ta = 0.01;            
fc = 300;              
B_m = 150;              
h = fir1(40,[B_m*ts]);   

% MODULANTE PELA FUNCAO triangl.m
m_sig = triangl((t + 0.01)/0.01) - triangl((t - 0.01)/0.01);
Lm_sig = length(m_sig);
Lfft = 2^ceil(log2(length(t))); 

% TF DO MODULANTE 
M_fre = fftshift(fft(m_sig,Lfft));
freqm = (-Lfft/2:Lfft/2-1)/(Lfft*ts); 

% MODULANDO O SINAL 
s_dsb = m_sig .* cos(2*pi*fc*t);
Lfft = 2^ceil(log2(length(t))+1); 

% TF DO MODULADO 
S_dsb = fftshift(fft(s_dsb,Lfft));
freqs = (-Lfft/2:Lfft/2-1)/(Lfft*ts);

% MULTIPLICANDO A PORTADORA PARA DEMODULAR 
s_dem=s_dsb.*cos(2*pi*fc*t)*2; 
S_dem=fftshift(fft(s_dem,Lfft));

% PASSA BAIXAS IDEAL EM 150HZ
s_rec=filter(h,1,s_dem); 
S_rec=fftshift(fft(s_rec,Lfft));

%% PLOTS 

% PLOT TRANSIENTE 
Trange=[-0.025 0.025 -2 2];
figure (1)

subplot(221) ;
td1=plot(t,m_sig) ;
axis(Trange); 
set(td1,'Linewidth',1.5);
xlabel('{\it t} (sec)'); 
ylabel('{\it m}({\it t})'); 
title('Sinal Modulante');

subplot(222) ;
td2=plot(t,s_dsb) ;
axis(Trange); 
set(td2,'Linewidth',1.5);
xlabel('{\it t} (sec)'); 
ylabel('{\it s}_{\rm DSB}({\it t})') 
title('Sinal Modulado DSB-SC');

subplot(223) ;
td3=plot(t,s_dem) ;
axis(Trange); 
set(td3,'Linewidth',1.5);
xlabel('{\it t} (sec)'); 
ylabel('{\it e}({\it t})') 
title('Sinal Demodulado');

subplot(224) ;
td4=plot(t,s_rec) ;
axis(Trange); 
set(td4,'Linewidth',1.5);
xlabel('{\it t} (sec)'); 
ylabel('{\it m}_d({\it t})') 
title('Sinal Recuperado');

% PLOT FFT
Frange=[-700 700 0 200];
figure(2)

subplot(221);
fd1=plot(freqm,abs(M_fre));
axis(Frange); 
set(fd1,'Linewidth',1.5); 
xlabel('{\it f} (Hz)');
ylabel('{\it M}({\it f})'); 
title('Espectro da Modulante');

subplot(222);
fd2=plot(freqs,abs(S_dsb));
axis(Frange); 
set(fd2,'Linewidth',1.5);
xlabel('{\it f} (Hz)');
ylabel('{\it S}_{rm DSB}({\it f})'); 
title('Espectro DSB-SC');

subplot(223) ;
fd3=plot(freqs,abs(S_dem) ) ;
axis(Frange); 
set(fd3,'Linewidth',1.5);
xlabel('{\it f} (Hz)'); 
ylabel('{\it E}({\it f})'); 
title('Espectro do Sinal Demodulado');

subplot(224) ;
fd4=plot(freqs,abs(S_rec) ) ;
axis(Frange); 
set(fd4,'Linewidth',1.5);
xlabel('{\it f} (Hz)'); 
ylabel('{\it M}_d({\it f})'); 
title('Espectro do Sinal Recuperado');