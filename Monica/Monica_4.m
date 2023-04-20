% close all 
% clear all
% 
% %% Definicoes 
% 
% ts=1.e-4;                       % Tamanho do passo 
% t=-0.04:ts:0.04;                % Vetor tempo 
% Ta=0.01;                        % Periodo triangl
% 
%                                 % Mensagem
% m_sig=triangl((t+0.01)/Ta)-triangl((t-0.01)/Ta);   
% Lfft=length(t);                                     
% Lfft=2^ceil(log2(Lfft));
% M_fre=fftshift(fft(m_sig,Lfft));% TF da Mensagem
% freqm=(-Lfft/2:Lfft/2-1)/(Lfft*ts);
% 
% kf=160*pi;                      % Sensibividade da frequencia 
% m_intg=kf*ts*cumsum(m_sig);     % kf * a(t)
% 
% % Modulacao:
% 
% fp=300;                         % Frequencia da portadora 
% s_fm=cos(2*pi*fp*t+m_intg);     % Modulacao da FM             
% s_pm=cos(2*pi*fp*t+pi*m_sig);   % Modulacao da PM
% Lfft=length(t);                 % Aqui faz a TF deles
% Lfft=2^ceil(log2(Lfft)+1);
% S_fm=fftshift(fft(s_fm,Lfft)); 
% S_pm=fftshift(fft(s_pm,Lfft));
% freqs=(-Lfft/2:Lfft/2-1)/(Lfft*ts);
% 
% % Demodulacao usando LPF ideal com largura de 200 Hz:
% 
% B_m=100;                        % A largura de banda eh B_m Hz
% 
% h=fir1(80,[B_m*ts]);            % Passa-Baixa 
%                                 % com largura de banda de B_m Hz
%                                 
%                                 % Deriva
% s_fmdem=diff([s_fm(1) s_fm])/ts/kf;                 
% s_fmrec=s_fmdem.*(s_fmdem>0);   % Retifica
% 
%  % Filtra. A saida ja eh o sinal recuperado:
% s_dec=filter(h,1,s_fmrec);     
% 
% %% Plots 
% 
% Trangel=[-0.04 0.04 -1.2 1.2];
% Frange = [-fp-200 fp+200 0 300];
% 
% figure(1)
% subplot(211);
% ml=plot(t,m_sig);
% axis(Trangel); 
% set(ml,'Linewidth',2);
% xlabel('{\it t} (sec)'); 
% ylabel('{\it m}({\it t})'); 
% title('Mensagem');
% subplot(212);
% m2=plot(t,s_dec);
% set(m2,'Linewidth',2);
% xlabel('{\it t} (sec)'); 
% ylabel('{\it m}_d({\it t})') 
% title('Sinal FM Demodulado');
% 
% figure(2)
% subplot(211);
% tdl=plot(t,s_fm);
% axis(Trangel); 
% set(tdl,'Linewidth',2);
% xlabel('{\it t} (sec)'); 
% ylabel('{\it s}_{\rm FM}({\it t})') 
% title('Sinal FM');
% subplot(212);
% td2=plot(t,s_pm);
% axis(Trangel); 
% set(td2,'Linewidth',2);
% xlabel('{\it t} (sec)'); 
% ylabel('{\it s}_{\rm PM}({\it t})')
% title('Sinal PM');
% 
% figure(3)
% subplot(211);
% fp1=plot(t,s_fmdem);
% set(fp1,'Linewidth',2);
% xlabel('{\it t} (sec)');
% ylabel('{\it d s}_{\rm FM}({\it t})/dt') 
% title('Derivada da FM');
% subplot(212);
% fp2=plot(t,s_fmrec);
% set(fp2,'Linewidth',2);
% xlabel('{\it t} (sec)');
% title('Derivada da FM retificada');
% 
% figure(4)
% subplot(211);
% fdl=plot(freqs,abs(S_fm));
% axis(Frange); 
% set(fdl,'Linewidth',2);
% xlabel('{\itf} (Hz)');
% ylabel('{\itS}_{\rmFM}({\itf})'); 
% title('Espectro de Amplitudes FM');
% subplot(212); 
% fd2=plot(freqs,abs(S_pm));
% axis(Frange);
% set(fd2,'Linewidth',2);
% xlabel('{\itf} (Hz)');
% ylabel('{\itS}_{\rmPM}({\itf})');
% title('Espectro de Amplitudes PM');

%% 

% Mesmo codigo com as modificacoes. Para usar, comentar o outro!

%% 

close all 
clear all

%% Definicoes 

ts=1.e-5;                       % Tamanho do passo %%
t=-0.04:ts:0.04;          % Vetor tempo %%
Ta=0.01;                        % Periodo triangl 

% O periodo da triangl deve ser o mesmo, afinal a 
% mensagem nao mudou

                                % Mensagem
m_sig=triangl((t+0.01)/Ta)-triangl((t-0.01)/Ta);   
Lfft=length(t);                                     
Lfft=2^ceil(log2(Lfft));
M_fre=fftshift(fft(m_sig,Lfft));% TF da Mensagem
freqm=(-Lfft/2:Lfft/2-1)/(Lfft*ts);

kf=5500*pi;                      % Sensibividade da frequencia 
m_intg=kf*ts*cumsum(m_sig);     % kf * a(t)

% Modulacao:

fp=1e4;                       % Frequencia da portadora %%
s_fm=cos(2*pi*fp*t+m_intg);     % Modulacao da FM             
s_pm=cos(2*pi*fp*t+pi*m_sig);   % Modulacao da PM
Lfft=length(t);                 % Aqui faz a TF deles
Lfft=2^ceil(log2(Lfft)+1);
S_fm=fftshift(fft(s_fm,Lfft)); 
S_pm=fftshift(fft(s_pm,Lfft));
freqs=(-Lfft/2:Lfft/2-1)/(Lfft*ts);

% Demodulacao usando LPF ideal com largura de 200 Hz:

B_m=100;                        % A largura de banda eh B_m Hz

h=fir1(80,[B_m*ts]);            % Passa-Baixa 
                                % com largura de banda de B_m Hz
                                
                                % Deriva
s_fmdem=diff([s_fm(1) s_fm])/ts/kf;                 
s_fmrec=s_fmdem.*(s_fmdem>0);   % Retifica

 % Filtra. A saida ja eh o sinal recuperado:
s_dec=filter(h,1,s_fmrec);     

%% Plots 

Trangel=[-0.04 0.04 -1.2 1.2];

% Adaptacao do range:
Frange = [-fp-10000 fp+10000 0 300];

figure(1)
subplot(211);
ml=plot(t,m_sig);
axis(Trangel); 
set(ml,'Linewidth',2);
xlabel('{\it t} (sec)'); 
ylabel('{\it m}({\it t})'); 
title('Mensagem');
subplot(212);
m2=plot(t,s_dec);
set(m2,'Linewidth',2);
xlabel('{\it t} (sec)'); 
ylabel('{\it m}_d({\it t})') 
title('Sinal FM Demodulado');

figure(2)
subplot(211);
tdl=plot(t,s_fm);
axis(Trangel); 
set(tdl,'Linewidth',2);
xlabel('{\it t} (sec)'); 
ylabel('{\it s}_{\rm FM}({\it t})') 
title('Sinal FM');
subplot(212);
td2=plot(t,s_pm);
axis(Trangel); 
set(td2,'Linewidth',2);
xlabel('{\it t} (sec)'); 
ylabel('{\it s}_{\rm PM}({\it t})')
title('Sinal PM');

figure(3)
subplot(211);
fp1=plot(t,s_fmdem);
set(fp1,'Linewidth',2);
xlabel('{\it t} (sec)');
ylabel('{\it d s}_{\rm FM}({\it t})/dt') 
title('Derivada da FM');
subplot(212);
fp2=plot(t,s_fmrec);
set(fp2,'Linewidth',2);
xlabel('{\it t} (sec)');
title('Derivada da FM retificada');

figure(4)
subplot(211);
fdl=plot(freqs,abs(S_fm));
axis(Frange); 
set(fdl,'Linewidth',2);
xlabel('{\itf} (Hz)');
ylabel('{\itS}_{\rmFM}({\itf})'); 
title('Espectro de Amplitudes FM');
subplot(212); 
fd2=plot(freqs,abs(S_pm));
axis(Frange);
set(fd2,'Linewidth',2);
xlabel('{\itf} (Hz)');
ylabel('{\itS}_{\rmPM}({\itf})');
title('Espectro de Amplitudes PM');