% LuÃsa Silva Dantas de Oliveira - 10821102
% PrincÃpios de Comunica¡?o - Estudo Dirigido 1
% ExercÃcio 1 - Modula¡?o SSB-SC
% -------------------------------------------------------------------------

%% Modula¡?o e demodula¡?o - SSB-SC

ts = 1.e-4;              %tempo de amostragem
t = -0.04:ts:0.04;       %comprimento
Ta = 0.01;               %par?metro da triplesinc
fc = 500;                %frequÕncia de corte
B_m = 150;               %largura de banda (Hz)
h = fir1(40,[ B_m*ts ]); %filtro FIR -> fir1(ordem , freq de corte)


% Sinal mensageiro a partir de triangl.m
m_sig = triangl((t + 0.01)/0.01) - triangl((t - 0.01)/0.01);
Lm_sig = length(m_sig);
Lfft = 2^ceil(log2(length(t)));
% TF de m_sig com componente de freq 0 no centro
M_fre = fftshift(fft(m_sig,Lfft));
freqm = (-Lfft/2 : Lfft/2-1) / (Lfft*ts);

% Sinal SSB (requer apenas metade de largura de banda do sinal DSB)
s_dsb = m_sig .* cos(2*pi*fc*t);
Lfft = 2^ceil(log2(length(t))+1);
% TF
S_dsb = fftshift(fft(s_dsb,Lfft));
L_lsb = floor(fc*ts*Lfft);
SSBfilt = ones(1,Lfft);     
SSBfilt(Lfft/2-L_lsb+1:Lfft/2+L_lsb) = zeros(1,2*L_lsb);   
S_ssb = S_dsb .* SSBfilt;  
freqs = (-Lfft/2:Lfft/2-1)/(Lfft*ts);
s_ssb = real(ifft(fftshift(S_ssb)));   
s_ssb = s_ssb(1:Lm_sig); 

% A demodula¡?o come¡a com a multiplica¡?o pela portadora
s_dem = s_ssb .* cos(2*pi*fc*t) * 2;
S_dem= fftshift(fft(s_dem,Lfft));

% Filtro passa baixas com largura de banda 150Hz
s_rec = filter(h,1,s_dem);
S_rec = fftshift(fft(s_rec,Lfft)); 


% Plot dos sinais no domÃnio do tempo
Trange = [-0.025 0.025 -1 1];
figure(1)

% sinal mensageiro
subplot(221); 
tdl = plot(t,m_sig);
axis(Trange); set(tdl,'Linewidth',1.5);
xlabel('{\it t}(sec)'); ylabel('{\it m}({\it t})');
title ( ' sinal mensageiro ');

% sinal modulado
subplot(222); 
td2 = plot(t,s_ssb);
axis(Trange); set(td2,'Linewidth',1.5);
xlabel('{\it t}(sec)'); ylabel('{\it s}_ {\rm SSB}({\it t})');
title ( ' sinal modulado - SSB-SC ');

% sinal depois de multplicado pela portadora local
subplot(223); 
td3 = plot(t,s_dem);
axis(Trange); set(td3,'Linewidth',1.5);
xlabel('{\it t}(sec)'); ylabel('{\it e}({\it t})');
title ( 'depois de multplicado pela portadora local' );

% sinal recuperado
subplot(224); 
td4 = plot(t,s_rec);
axis(Trange); set(td4,'Linewidth',1.5);
xlabel('{\it t}(sec)'); ylabel('{\it m}_d({\it t})');
title ( ' sinal recuperado '); 


% Plot dos sinais no domÃnio da frequÕncia
Frange = [ -700 700 0 200];
figure(2)

% espectro do sinal mensageiro
subplot(221); 
fdl = plot(freqm, abs(M_fre));
axis(Frange); set(fdl,'Linewidth',1.5);
xlabel('{\it f}(Hz)'); ylabel('{\it M}({\it f})');
title ( ' espectro do sinal mensageiro ' ); 

% espectro da banda sup. - SSB-SC
subplot(222); 
fd2 = plot(freqs,abs(S_ssb));
axis(Frange); set(fd2,'Linewidth',1.5);
xlabel('{\it f}(Hz)'); ylabel('{\it S}_{rm DSB}({\it f})');
title ( ' espectro da banda sup. - SSB-SC ' );

% espectro do sinal detectado
subplot(223); 
fd3 = plot(freqs,abs(S_dem));
axis(Frange); set(fd3,'Linewidth',1.5);
xlabel('{\it f}(Hz)'); ylabel('{\it E}({\it f})');
title ( ' espectro do sinal detectado ' );

% espectro do sinal recuperado
subplot(224); 
fd4 = plot(freqs,abs(S_rec));
axis(Frange);set(fd4,'Linewidth',1.5);
xlabel('{\it f}(Hz)'); ylabel('{\it M}_d({\it f})');
title ( ' espectro do sinal recuperado ' );

