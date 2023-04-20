close all;
clear all;
clc;

format longG


%% Tratamento dados capturados 

% 1 - Controle 
f1Table = csvread('f1.csv',2) ; % dBV x Hz
f1xaxis = f1Table(:,1); 
f1yaxis = f1Table(:,2);

% 2 - Copo vazio 
f2Table = csvread('f2.csv',2) ; % dBV x Hz
f2xaxis = f2Table(:,1); 
f2yaxis = f2Table(:,2);

% 3 - Copo na metade 
f3Table = csvread('f3.csv',2) ; % dBV x Hz
f3xaxis = f3Table(:,1); 
f3yaxis = f3Table(:,2);

% 4 - Copo cheio 
f4Table = csvread('f4.csv',2) ; % dBV x Hz
f4xaxis = f4Table(:,1); 
f4yaxis = f4Table(:,2);

figure(1)
subplot(2,2,1); plot(f1xaxis,f1yaxis); 
title('Ensaio I - Controle'); xlabel('Hz'); ylabel('dBV')
subplot(2,2,2); plot(f2xaxis,f2yaxis);
title('Ensaio II'); xlabel('Hz'); ylabel('dBV')
subplot(2,2,3); plot(f3xaxis,f3yaxis);
title('Ensaio III'); xlabel('Hz'); ylabel('dBV')
subplot(2,2,4); plot(f4xaxis,f4yaxis);
title('Ensaio IV'); xlabel('Hz'); ylabel('dBV')

% Identificacao das harmonicas

f=[25.1e3 2*25.1e3 3*25.1e3 4*25.1e3 5*25.1e3 6*25.1e3 7*25.1e3];
index=1;a=0;harmf1=[];harmf2=[];harmf3=[];harmf4=[];

for i=1:1:length(f)
    while a~=f(i)
        index=index+1;
        a=f1xaxis(index);
    end
    f(i)=index;         % f guarda o indice referente as harmonicas
    
    % Criando vetores com os valores em dB das harmonicas
    % Maximo local em torno do indice para evitar desvios    
    harmf1=[harmf1 (max(f1yaxis(index-10:index+10)))];
    harmf2=[harmf2 (max(f2yaxis(index-10:index+10)))];
    harmf3=[harmf3 (max(f3yaxis(index-10:index+10)))];
    harmf4=[harmf4 (max(f4yaxis(index-10:index+10)))];
end
clear i a; 

harmf1rms=[10.^(harmf1/20)];harmf2rms=[10.^(harmf2/20)];
harmf3rms=[10.^(harmf3/20)];harmf4rms=[10.^(harmf4/20)];

%% Analise do ruido

f1noise=f1yaxis; floorf1(1:21)=[min(f1noise)];
f2noise=f2yaxis; floorf2(1:21)=[min(f2noise)];
f3noise=f3yaxis; floorf3(1:21)=[min(f3noise)];
f4noise=f4yaxis; floorf4(1:21)=[min(f4noise)];

% Limpando os 10 valores em torno das harmonicas para obter o ruido 
for i=1:1:length(f)
    f1noise(f(i)-10:f(i)+10)=[floorf1];
    f2noise(f(i)-10:f(i)+10)=[floorf2];
    f3noise(f(i)-10:f(i)+10)=[floorf3];
    f4noise(f(i)-10:f(i)+10)=[floorf4];
end
clear i;

figure(2)
subplot(2,2,1); plot(f1xaxis,f1noise);

subplot(2,2,2); plot(f2xaxis,f2noise);

subplot(2,2,3); plot(f3xaxis,f3noise);

subplot(2,2,4); plot(f4xaxis,f4noise);

% Calculando o valor RMS do ruido na banda
nrmsf1=sum(10.^(f1noise(:)/20))/length(f1noise);
nrmsf2=sum(10.^(f2noise(:)/20))/length(f2noise);
nrmsf3=sum(10.^(f3noise(:)/20))/length(f3noise);
nrmsf4=sum(10.^(f4noise(:)/20))/length(f4noise);

% O ruido da banda inteira nao muda de maneira correlacionda com o volume 

%% Plotando os harmonicos das medidas para observar a variacao
figure(3); hold on; title('Amplitude de cada harmonico')
plot(harmf1rms,'*','MarkerSize',18); plot(harmf2rms,'*','MarkerSize',18); 
plot(harmf3rms,'*','MarkerSize',18); plot(harmf4rms,'*','MarkerSize',18); 
legend({'Controle','Ensaio II','Ensaio III','Ensaio IV'},'FontSize',18);

% Calculando o desvio padrao de cada harmonico
% em cada ensaio (menos controle)
varmed=[];
for i=1:1:7
    varmed=[varmed std([harmf2(i) harmf3(i) harmf4(i)])];
end
clear i;

figure(4)
plot(varmed); title({'Desvio padrao por harmonico'},'FontSize',18);
xlabel('n'); ylabel('DP')

% A fundamental muda pouco, enquanto que as demais componentes 
% mudam de maneira aprox. monotonamente decrescente  

%% Determinando a distorcao harmonica do meio

thdn1=sqrt(sum(harmf1rms(2:end).^2)+nrmsf1^2)/harmf1rms(1);
thdn2=sqrt(sum(harmf2rms(2:end).^2)+nrmsf2^2)/harmf2rms(1);
thdn3=sqrt(sum(harmf3rms(2:end).^2)+nrmsf3^2)/harmf3rms(1);
thdn4=sqrt(sum(harmf4rms(2:end).^2)+nrmsf4^2)/harmf4rms(1);

figure(5); hold on; title({'THD+N'},'FontSize',18);
plot([thdn2 thdn3 thdn4],'*','MarkerSize',18); 
plot([thdn2 thdn3 thdn4],'MarkerSize',18); 

% O THD+N cresce de maneira linear com o aumento do volume!

%% Determinando uma distorcao com peso monotonamente decrescente 

thdpn1=[];thdpn2=thdpn1;thdpn3=thdpn2;thdpn4=thdpn3;
for i=2:1:7
    thdpn1=[thdpn1 harmf1rms(i)*49/i^2];
    thdpn2=[thdpn2 harmf2rms(i)*49/i^2];
    thdpn3=[thdpn3 harmf3rms(i)*49/i^2];
    thdpn4=[thdpn4 harmf4rms(i)*49/i^2];
end
thdpn1=sqrt(sum(thdpn1(:).^2))/harmf1rms(1);
thdpn2=sqrt(sum(thdpn2(:).^2))/harmf2rms(1);
thdpn3=sqrt(sum(thdpn3(:).^2))/harmf3rms(1);
thdpn4=sqrt(sum(thdpn4(:).^2))/harmf4rms(1);

figure(6); hold on; title({'PTHD+N'},'FontSize',18);
plot([thdpn2 thdpn3 thdpn4],'*','MarkerSize',18); 
plot([thdpn2 thdpn3 thdpn4],'MarkerSize',18); 

% Com essa definicao, os resultados crescem na mesma maneira que 
% o volume, mas com um comportamento fortemente logaritmico 

%% Encontrando a base do logaritmo que aproxima a funcao da variacao de vol

vol1=(3^(thdn2)-1.6)*100;
vol2=(3^(thdn3)-1.6)*100;
vol3=(3^(thdn4)-1.6)*100;

volp1=pi^(thdpn2);
volp2=pi^(thdpn3);
volp3=pi^(thdpn4);

figure(7); hold on; title({'Metrica exponencial do THD+N'},'FontSize',18);
plot([vol1 vol2 vol3]); 
plot([volp1 volp2 volp3]);
legend({'THD+N','PTHD+N'},'FontSize',18)
