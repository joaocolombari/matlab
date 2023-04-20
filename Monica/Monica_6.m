% -------------------------------------- % 
%      FM Modulação e demodulação        %
%         Com Adicao de Ruido            %
% -------------------------------------- % 

%% 

close all 
clear all

%% Definicoes 

ts=1.e-6;                       % Tamanho do passo 
t=-0.04:ts:0.04;                % Vetor tempo 

% Ruido 

% Faz ruido quase aleatorio do tamanho de t
nois = randn(length(t),1);
                               
m_sig=cos(2*pi*1e2*t);            % Mensagem
Lfft=length(t);                                     
Lfft=2^ceil(log2(Lfft));
M_fre=fftshift(fft(m_sig,Lfft));% TF da Mensagem
freqm=(-Lfft/2:Lfft/2-1)/(Lfft*ts);

% Rotina para calcular SNR:
% 30dB de SNR quer dizer uma razao 
% de 31.6227 das tensoes de sinal p
% ruido

rms_m = rms(m_sig);
rms_n = rms(nois);

while rms_m/rms_n < 31.6227
    nois=0.99*nois;
    rms_n=rms(nois);
end


kf=200;                     % Sensibilidade
m_intg=kf*ts*cumsum(m_sig);     % kf * a(t)

% Dados do PB do demodulador, com larg
% ura de 110Hz, comportando a mensagem:
h=fir1(10000,[110*ts]);         
                                
% Dados do PB do pre filtro, com largura
% que comporta a modulada:
h2=fir1(55,[1e5*ts]);                                

%% Modulacao:

fp=1e4;                         % Frequencia da portadora 
s_fm=cos(2*pi*fp*t+m_intg);     % Modulacao da FM    

% Mesma coisa mas com ruido
% Somando a modulada ao ruido:
for i=1:1:length(t)
    s_fm_nois(i) = s_fm(i)+nois(i); 
end  

S_fm=fftshift(fft(s_fm,Lfft)); 
S_fm_nois=fftshift(fft(s_fm_nois,Lfft)); 
freqs=(-Lfft/2:Lfft/2-1)/(Lfft*ts);

%% Demodulacao:
  
% Novamente, nao vou fazer mais um vetor,
% chamarei o filtro dentro do prox. passo
% do demodulador para economizar programa.

% Sem ruido:                  
                                % Deriva
s_fmdem=diff([s_fm(1) s_fm])/ts/kf;                 
s_fmrec=s_fmdem.*(s_fmdem>0);   % Retifica

% Com ruido:
                                % Deriva
s_fmdem_nois=diff([filter(h2,1,s_fm_nois(1)) filter(h2,1,s_fm_nois)])/ts/kf;
                                % Retifica
s_fmrec_nois=s_fmdem_nois.*(s_fmdem_nois>0);   

% Filtra. A saida ja eh o sinal recuperado:
s_dec=filter(h,1,s_fmrec);     
s_dec_nois=filter(h,1,s_fmrec_nois);  

%% Erro 

% Calculo do erro da saida 
err_out = immse(s_dec,s_dec_nois)

%% Plots sem ruido

Trangel=[-0.04 0.04 -1.2 1.2];

% Adaptacao do range:
Frange = [-fp-10000 fp+10000 0 300];

figure(1)
subplot(211);
ml=plot(t,m_sig);
axis(Trangel); 
set(ml,'Linewidth',2);
xlim([-0.03 0.03])
xlabel('{\it t} (sec)'); 
ylabel('{\it m}({\it t})'); 
title('Mensagem');
subplot(212);
m2=plot(t,s_dec);
xlim([-0.03 0.03])
set(m2,'Linewidth',2);
xlabel('{\it t} (sec)'); 
ylabel('{\it m}_d({\it t})') 
title('Sinal FM Demodulado');

figure(2)
tdl=plot(t,s_fm);
axis(Trangel); 
xlim([-0.005 0.005])
set(tdl,'Linewidth',2);
xlabel('{\it t} (sec)'); 
ylabel('{\it s}_{\rm FM}({\it t})') 
title('Sinal FM');

figure(3)
subplot(211);
fp1=plot(t,s_fmdem);
set(fp1,'Linewidth',2);
xlabel('{\it t} (sec)');
xlim([-0.005 0.005])
ylabel('{\it d s}_{\rm FM}({\it t})/dt') 
title('Derivada da FM');
subplot(212);
fp2=plot(t,s_fmrec);
xlim([-0.005 0.005])
ylim([0 350])
set(fp2,'Linewidth',2);
xlabel('{\it t} (sec)');
title('Derivada da FM retificada');

figure(4)
fdl=plot(freqs,abs(S_fm));
axis(Frange); 
set(fdl,'Linewidth',2);
ylim([0 2000])
xlabel('{\itf} (Hz)');
ylabel('{\itS}_{\rmFM}({\itf})'); 
title('Espectro de Amplitudes FM');

%% Plots com ruido

Trangel=[-0.04 0.04 -1.2 1.2];

% Adaptacao do range:
Frange = [-fp-10000 fp+10000 0 300];

figure(5)
subplot(211);
ml=plot(t,m_sig);
axis(Trangel); 
set(ml,'Linewidth',2);
xlim([-0.03 0.03])
xlabel('{\it t} (sec)'); 
ylabel('{\it m}({\it t})'); 
title('Mensagem');
subplot(212);
m2=plot(t,s_dec_nois);
xlim([-0.03 0.03])
set(m2,'Linewidth',2);
xlabel('{\it t} (sec)'); 
ylabel('{\it m}_d({\it t})') 
title('Sinal FM com Ruído Demodulado');

figure(6)
tdl=plot(t,s_fm_nois);
axis(Trangel); 
xlim([-0.005 0.005])
set(tdl,'Linewidth',2);
xlabel('{\it t} (sec)'); 
ylabel('{\it s}_{\rm FM}({\it t})') 
title('Sinal FM');

figure(7)
subplot(211);
fp1=plot(t,s_fmdem_nois);
set(fp1,'Linewidth',2);
xlabel('{\it t} (sec)');
xlim([-0.005 0.005])
ylabel('{\it d s}_{\rm FM}({\it t})/dt') 
title('Derivada da FM');
subplot(212);
fp2=plot(t,s_fmrec_nois);
xlim([-0.005 0.005])
ylim([0 350])
set(fp2,'Linewidth',2);
xlabel('{\it t} (sec)');
title('Derivada da FM retificada');

figure(8)
fdl=plot(freqs,abs(S_fm_nois));
axis(Frange); 
set(fdl,'Linewidth',2);
ylim([0 2000])
xlabel('{\itf} (Hz)');
ylabel('{\itS}_{\rmFM}({\itf})'); 
title('Espectro de Amplitudes FM');
