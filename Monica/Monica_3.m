% -------------------------------------- % 
%       SSB Modulacao e demodulacao      %
% -------------------------------------- % 

%% 

close all 
clear all

ts = 1.e-4;
t = -0.04:ts:0.04;
Ta = 0.01;
fc = 300;
B_m = 150;
h=fir1(40,[B_m*ts]);

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
s_dsb=m_sig.*cos(2*pi*fc*t);
Lfft=2^ceil(log2(length(t))+1); 

% TF DA DSB
S_dsb = fftshift(fft(s_dsb,Lfft));
L_lsb = floor(fc*ts*Lfft);
SSBfilt = ones(1,Lfft);     
SSBfilt(Lfft/2-L_lsb+1:Lfft/2+L_lsb) = zeros(1,2*L_lsb);   
S_ssb = S_dsb .* SSBfilt;  
freqs = (-Lfft/2:Lfft/2-1)/(Lfft*ts);
s_ssb = real(ifft(fftshift(S_ssb)));   
s_ssb = s_ssb(1:Lm_sig); 

% INICIO DA DEMODULACAO COM A MULTIPLICACAO PELA PORTADORA
s_dem=s_ssb.*cos(2*pi*fc*t)*2; 
S_dem=fftshift(fft(s_dem,Lfft));

% PASSA BAIXA IDEAL CORTANDO EM 150 Hz 
s_rec=filter(h,1,s_dem); 
S_rec=fftshift(fft(s_rec,Lfft) ) ;

%% PLOTS 

% PLOT TRANSIENTE

Trange=[-0.025 0.025 -1 1];
figure(1)

subplot(221) ;
td1=plot(t,m_sig) ;
axis(Trange); 
set(td1,'Linewidth',1.5);
xlabel('{\it t} (sec}'); 
ylabel('{\it m}({\it t})'); 
title('Sinal Modulador');

subplot(222);
td2=plot(t,s_ssb);
axis(Trange);
set(td2,'Linewidth',1.5);
xlabel('{\it t} (sec}'); 
ylabel('{\it s}_{\rm SSB}({\it t}}') 
title ('Sinal Modulado SSB-SC');

subplot(223);
td3=plot(t,s_dem);
axis(Trange); 
set(td3,'Linewidth',1.5);
xlabel('{\it t} (sec}'); 
ylabel('{\it e}({\it t})')
title('Depois de Multiplicar pela Portadora do Receptor');

subplot(224); 
td4=plot(t, s_rec);
axis(Trange); 
set(td4,'Linewidth',1.5);
xlabel('{\it t} (sec)');
ylabel('{\it m}_d({\it t})')
title ('Sinal Recuperado');

% PLOT FFT 

Frange=[-700 700 0 200] ;
figure ( 2 )

subplot(221) ;
fdl=plot(freqm,abs(M_fre));
axis(Frange);
set(fdl,'Linewidth',1.5); 
xlabel('{\it f} (Hz)'); 
ylabel('{\it M}({\it f}}'); 
title('Espectro da Modulante');

subplot(222) ;
fd2=plot(freqs,abs(S_ssb) ) ;
axis(Frange) ; 
set(fd2, 'Linewidth' ,1.5) ;
xlabel('{\itf} (Hz)');
ylabel('{\itS}_{rmDSB}({\itf})'); 
title('Espectro USB SSB-SC ');

subplot(223) ;
fd3=plot(freqs,abs(S_dem) ) ;
axis(Frange); 
set(fd3,'Linewidth',1.5);
xlabel('{\itf} (Hz)');
ylabel('{\itE}({\itf})'); 
title('Espectro Detector');

subplot(224) ;
fd4=plot(freqs,abs(S_rec) ) ;
axis(Frange); 
set(fd4,'Linewidth',1.5);
xlabel('{\itf} (Hz)');
ylabel('{\itM}_d({\itf})');
title('Espectro do Sinal Recuperado');