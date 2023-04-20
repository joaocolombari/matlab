%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Trabalho Computacional João Colombari %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%se não da o fftshift NAO PODE PLOTAR DE -0.5 a 0.5
%Sem o fftshift o cara ta sabendo dos pontos de 0 a 1

%k = (0:1:Np-1); %esse é o k da DFT
%ksh = k-Np/2

%v = k/Np
%vsh = ksh/Np %eh esse cara que eu multiplico por fs pra fazer o f, justamente 
                %pq vai de -meio a meio

%summerising, eu nao posso usar o sem shift por que a tf soh eh calculada de 
%-meio a meio, fora desse intervalo eu sei lah



clear all
close all

%% Coisiquinhas

A=20;                                       %Valores da Gaussiana
sigma=100;

Ts=sigma/10;                                % Período e frequencia de amostragem
fs=1/Ts;

Np=2^10;                                    % Numero de pontos do vetor 

n=(0:1:Np-1)-Np/2;                          %Variavel discreta e t discretizado
t=Ts*n;

%% Funcoes

x=A*exp(-(t./sigma).^2);                    %Essa aqui é a gaussiana f(nTs)

% Ainda nao vou definir a Xana aqui por que o f precisa de explicacao

figure(1)                                   % Plota x(t)
plot(t,x,'r')
title('Gaussiana')
xlabel('tempo')
ylabel('Amplitude')
xlim([t(1) t(Np)])

%% Questão 01:

% Minha explicacao deve ter:
% 1 - Como gerar o vetor de índice k da DFT que a fft calcula;
% 2 - Como gerar o vetor v da DTFT;
% 3 - Como gerar o vetor de frequências f em Hertz;
% 4 - Como gerar um vetor que armazene amostras da TF (preste atenção, 
%     eu falei TF, e não DFT ou DTFT) da sua função exemplo, utilizando  
%     a função fft do matlab.
% 5 - Explique o papel do comando fftshift e explique o porquê dos 
%     vetores k, v e f serem gerados como foram gerados.
% 6 - Plote a TF obtida da fft junto com a TF analítica e confira que bate em cima.
% 7 - Uma vez plotada a TF, explique como encontrar a TF inversa utilizando
%     o comando ifft, e o vetor com amostras da TF obtido anteriormente. 
%     Lembre-se que a função ifft quer como entrada a DFT gerada pela função 
%     fft. Gere a TF inversa e compare com o seu vetor com a gaussiana original, 
%     que você usou para gerar a TF (plotando os dois juntos contra o vetor 
%     tempo). Os dois vetores têm que ser
%     virtualmente idênticos.

% 1 

% A definicao de k (da DTF) vem da definicao do comando fft. Ja que o comando 
% calcula com X[k] para (k-1), o range de vs q a DTF calcula comeca em 0 e
% vai ate quase 1 (1-1/Np). Ja que o k deve ter Np pontos:

k=(0:1:Np-1);   

% Mas, como disse, esse k so eh util para valores de 0 a Np. Se quiser
% utilizar o vetor para construir algo que mostre a TF, tenho transladar
% com Np/2, encaixando o vetor no primeiro periodo da TF, pondendo entao
% usar para construi-la.

ksh=k-Np/2;

% 2 

% O v da minha DTFT é um vetor de Np pontos mas que vai de 0 ate 1. Entao
% eh so usar a mesma definicao, ajeitando os valores.

v=k/Np;

% Se eu quiser plotar a DTFT de menos meio a meio DEVO usar o vetor v
% transladado, de maniera a adequa-lo no periodo de interesse.

vsh=ksh/Np;

% 3 

% Para o vetor de frequencias, acaba ficando como no Trabalho 1. La fiz a
% mesma coisa que vou fazer aqui, arrumando o vetor que vai de -meio a meio
% com o fs para ai sim poder construir minha TF.

f=vsh*fs;

% 4

% Para criar a TF vou usar o FFT no meu vetor da x(t)

X_DFT=fft(x);

% Isso entao calculou a DTF que ta indo de 0 a 1. Se quiser plotar alguma
% coisa aqui tem que usar o k ou v. 

X_TF=(1/fs)*fftshift(X_DFT);

% Aqui ja tenho o vetor com amostras da TF de x(t). Se quiser plotar eh soh
% utilizar a f que fiz na parte 3.

% 5 

% Ja fui explicando ate essa parte, mas recapitulando: A fft calcula um
% vetor com a DFT (amostras da DTFT) do vetor x (que por sua vez tem as
% amostras da x(t)) do ponto 0 ate o ponto 1 - 1/Np. Quando eu uso o 
% comando fftshift, eu estou trazendo o ponto final sobre dois + 1 para o 
% ponto zero. O vetor da DFT esta sendo trocado de posicao. A primeira
% metade, de 0 a Np/2-1 entra no lugar da segunda, de Np/2 a Np-1. Quando 
% defino os novos valores de k, v e (portanto) f, o que estou fazendo eh 
% transladar o eixo (que vai ser o horizontal) de maneira que as 
% informacoes (amostras) sejam correspondentes as posicoes (k, v ou f).

% 6 

Xanaf = f*0;                                % Esse é minha TF analitica
for u = 1:length(f)
    Xanaf(u) = A*sigma*sqrt(pi)*exp(-(pi*sigma*f(u))^2);
end

figure(2)                                   % Plota a comparacao entre TF
plot(f,abs(X_TF),'k',f,abs(Xanaf),'b.')     % obtida por fft e TF analitica
title('Comparação TF fft e TF analitica')
xlabel('f')
ylabel('Amplitude')
legend('fft','Analitica')

% 7 

% Aqui eh trivial, como disse que o shift leva uma porcao de Np/2 a Np-1
% para o inicio enquanto leva a de 0 a Np/2-1 para o final, fazer isso
% novamente volta as coisas ao normal. Obvio que poderia usar o meu vetor
% X_DFT que da na mesma, mas vou fazer o que disse para evidenciar. Melhor:
% vou fazer os dois. Ah, claro, tem que acertar a amplitude com fs.

X_DFT_sh=fftshift(fs*X_TF);

x_fft_sh=ifft(X_DFT_sh);
x_fft=ifft(X_DFT);

figure(3)                                   
plot(t,x,'k',t,x_fft_sh,'b.',t,x_fft,'rs')      
title('Comparação das x(t)')                % Plota a comparacao entre x ana
xlabel('t')                                 % litica, x por ifft de um vetor 
ylabel('Amplitude')                         % com amostras da TF invertido e 
ylim([0 20])                                % x inverso de fft
xlim([t(1) t(Np)])
legend('Analitica','Da TF com shift','Da fft')           

%% Questao 02:

% Parte 1: Fazer a derivada em t no dominio f no vetor DA TF
% Passo 2: Gerar o vetor inverso pela ifft 
% Passo 3: Gerar um vetor da derivada de x(t) 
% Passo 4: Comparar 
% Passo 5: Bolar um preço decente pro tutorial 
% Passo 6: Criar um anúncio no eBay 
% Passo 7 (se nao vender em uma semana): Abaixar o preço em 25%
% Passo 8 (se nao vender mesmo assim): Abrir um leilao 
% Passo 9 (se MESMO ASSIM nao vender): Desistir e chorar em posicao fetal

% Passo 1:

% Vou soh derivar, nada de mais. Tem regrinhas no Lathi, pag. 629. 

X_TF_devx=1i*2*pi*f.*X_TF;

% Passo 2:

% Neste passo farei como fiz no ultimo passo da questao 1, lembrando de fs:

XTF_devx_sh=fftshift(fs*X_TF_devx);

x_devx=ifft(XTF_devx_sh);

% Passo 3: 

% Vou definir um vetor analitico da derivada de x.

devx=-2*A*t.*exp(-(t./sigma).^2)/(sigma^2);  

% Passo 4: 

figure(4)                                   
plot(t,devx,'k',t,x_devx,'b.')    
title('Comparação das Derivadas de x(t)')              
xlabel('t')                                
ylabel('Amplitude')
xlim([t(1) t(Np)])
legend('Analitica','Da TF com fft')    
