% -------------------------------------- % 
%          APDS - Trabalho 02            %
%      Joao Victor Colombari Carlet      %
% -------------------------------------- % 

% Questao 06 %

%% 

close all 
clear all

%% Definicoes 

ts=1.e-6;                       % Tamanho do passo 
t=-1.0:ts:1.0;                  % Vetor tempo 

% Ruido gaussiano
sigma2=1;                       % Valor RMS da Gauss
noisg=wgn(1,(2*1/ts+1),sigma2);

% Tons
sinC=1*sin(2*pi*65.41*t); % Do
sinE=1*sin(2*pi*82.41*t); % Mi
sinG=1*sin(2*pi*98.00*t); % Sol

%% Desenvolvimento 

% Periodograma do Ruido
P=periodogram(noisg);

% Plot
figure(1)
plot(P); title('Periodograma Ruido');
xlabel('Frequencia [hz]'); ylabel('Magnitude')

% Gera 10 vetores de 200 amostras do ruido
R1=noisg(1:200);    R2=noisg(201:400);
R3=noisg(401:600);  R4=noisg(601:800);
R5=noisg(801:1000); R6=noisg(1001:1200);
R7=noisg(1201:1400);R8=noisg(1401:1600);
R9=noisg(1601:1800);R10=noisg(1801:2000);

% Estima os Periodogramas
P1=periodogram(R1);P2=periodogram(R2);
P3=periodogram(R3);P4=periodogram(R4);
P5=periodogram(R5);P6=periodogram(R6);
P7=periodogram(R7);P8=periodogram(R8);
P9=periodogram(R9);P10=periodogram(R10);

% Periodograma medio
PM=(P1+P2+P3+P4+P5+P6+P7+P8+P9+P10)/10;

% Plot
figure(2)
subplot(2,1,1)
plot(P); title('Periodograma Ruido')
xlabel('Frequencia [hz]'); ylabel('Magnitude')
subplot(2,1,2)
plot(PM); title('Periodograma Medio Ruido')
xlabel('Frequencia [hz]'); ylabel('Magnitude')

% Para 10000 amostras
Ps=PM*10;
for i=1:1:9990
    Rs=noisg(2001+(i-1)*200:2000+i*200);
    Ps=Ps+periodogram(Rs);
end
Ps=Ps/(10+9990);

% Plot
figure(3)
subplot(2,1,1)
plot(P); title('Periodograma Ruido')
xlabel('Frequencia [hz]'); ylabel('Magnitude')
subplot(2,1,2)
plot(Ps); title('Periodograma Medio Ruido')
xlabel('Frequencia [hz]'); ylabel('Magnitude')

% Periodograma tons
[PC]=periodogram(sinC);
[PE]=periodogram(sinE);
[PG]=periodogram(sinG);
[PCw]=pwelch(sinC);
[PEw]=pwelch(sinE);
[PGw]=pwelch(sinG);

% Plot
figure(4); 
subplot(2,1,1); grid on; hold on;
plot(PC);plot(PE);plot(PG);title('Periodograma tons');
xlabel('\omega / \pi'); ylabel('Magnitude');
xlim([0 1000])
subplot(2,1,2); grid on; hold on;
plot(PCw);plot(PEw);plot(PGw);title('Periodograma Welch tons');
xlabel('f [Hz]'); ylabel('Magnitude');
xlim([0 250])

% Importando
[y,ts]=audioread('/Users/joaovitor/Documents/MATLAB/Monica/APDS_T2/Audio/violao.WAV');

% Gerando vetor tempo
x=linspace(0, length(y)/ts, length(y));

% Gera vetor de 1000 amostras 
R2=y(1:1000);                    % Inicio da track  

[Pmusica]=periodogram(y);
[Pmusicaw]=pwelch(y);

% Plot
figure(5); 
subplot(2,1,1); grid on; hold on;
plot(Pmusica); title('Periodograma tMusica');
xlabel('\omega / \pi'); ylabel('Magnitude');
xlim([0 1000])
subplot(2,1,2); grid on; hold on;
plot(Pmusicaw); title('Periodograma Welch Musica');
xlabel('f [Hz]'); ylabel('Magnitude');
xlim([0 250])


