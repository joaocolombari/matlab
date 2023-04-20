%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Trabalho Computacional João Colombari %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all
close all

%% Coisiquinhas

A=20;                                       %Valores da Gaussiana
sigma=100;

Ts=sigma/10;                                % Período e frequencia de amostragem
fs=1/Ts;

n=(-500:1:500);                             %Variavel discreta e t discretizado
t=Ts*n;

Nv=1e4;                                     % "frequencias" da DTFT
vi = 1.5;
passo = 2*vi/(Nv-1); 
v = (-vi:passo:vi);

%% Funcoes

x=A*exp(-(t./sigma).^2);                    %Essa aqui é a gaussiana f(nTs)

Xv = v*0;
for u = 1:length(v)
    Xv(u) = sum(x.*exp(-i*2*pi*v(u)*n));    %Essa é a DTFT da gaussiana
end

% Ta, essa é a questão 01 e eu tenho que, pela DTFT, pegar a TF. Eu faço
% isso escalonando as "frequencias" da DTFT. Pra ficar chiq da pra definir
% a TF e mandar plotar junto (Figura 3).

% Lembrar que a DTFT possui amplitude diferente da TF. Isso pode ser visto
% na Figura 9 da apostila.

%% Questão 01

% Passo 1: Escalonar o vetor de "frequencias" v;
% Passo 2: Definir uma TF pela eq 2 (analítica) e acertar a amplitude (fs);
% Passo 3: Plotar as duas.

f = v*0;                                    % Escalonei o v jogando em um
for u = 1:length(v)                         % vetor f
    f(u) = v(u)*fs;
end

Xanaf = f*0;                                % Esse é minha TF analitica
for u = 1:length(f)
    Xanaf(u) = A*sigma*sqrt(pi)*exp(-(pi*sigma*f(u))^2);
end


%% plots Questao 1

% figure(1)                                   % Plota f[n] = gaussiana
% plot(t,x,'r')
% title('Gaussiana')
% xlabel('tempo')
% ylabel('Amplitude')
% 
% figure(2)                                   % Plota a DTFT
% plot(v,abs(Xv),'b')
% title('DTFT')
% xlabel('v')
% ylabel('Módulo da DTFT')
% 
% figure(3)                                   % Plota a comparacao entre DTFT
% plot(f,abs(Xv),'k',f,abs(Xanaf),'b.')       % corrigida em f e TF analitica
% title('Comparação TF da DTFT e analitica')
% xlim([-3/2*fs 3/2*fs])
% xlabel('fs')
% ylabel('Amplitude')
% legend('Da DTFT','Analitica')

%% Conclusoes Questao 1: 

% Com a DTFT obtive as copias espacadas em uma unidade de 'v', bem como
% amplitude fs vezes menor que a ampkitude da TF analitica, como esperado.
% Ao corrigir a DTFT atraves do escalonamento do eixo de unidades 'v',
% produzi uma DTFT corrigida. Essa ainda nao pode ser chamada de TF pois
% carece de uma correcao de amplitude. A correcao de amplitude sera feita
% na questao 2.

%% Questao 02

% Parte 1: Calcular a TF pela eq. 54
% Passo 2: Calcular a soma pela def com DELTAt = Ts
% Passo 3: Comparar no plot
% Passo 4: Perguntas

% Lembrar que o meu f é t=n*Ts

% Calculo da TF pela eq. 54:

Xdf = f*0;
for u = 1:length(f)
    Xdf(u) = sum(x.*exp(-1i*2*pi*f(u)*t));   % Essa é a TF da gaussiana
end

% Note a equivalencia deste calculo com o que foi feito nas linhas 46-49.

% Calculo da Soma de Riemann como mostrado em 06/05:

Xf = f*0;
for u = 1:length(f)
    Xf(u) = sum(x.*exp(-1i*2*pi*f(u)*t)*Ts); % Calculo da S de R da gaussiana
end

% Comparando ambas num plot:

% figure(4)                                   % Plota o resultado das partes
% plot(f,abs(Xdf),'k',f,abs(Xf),'b',f,abs(Xanaf),'r')         % 1 e 2
% title('Comparação TF de Xd(t), da Soma de Riemann da TF e da TF Analitica')
% xlim([-3/2*fs 3/2*fs])
% xlabel('f')
% ylabel('Amplitude')
% legend('Xd(f)','X(f)','Xana(f)')

%% Adendo: 

% Mudando Ts para ver a TF aproximar a integral. Isso implica que as copias
% devem se espacar entre si, tendendo a ficar infinitamente espacadas, ou
% melhor, infinitamente proximas ao que o Grossi me ensinou..

Ts2=Ts/10;                                  % Definindo tudo novamente para 
fs2=1/Ts2;                                  % espacar as copias em 10x 
t2=Ts2*n;

x2=A*exp(-(t2./sigma).^2);                    % Definir x com novo t          

f2 = v*0;                                   % Escalonando v com o novo fs
for u = 1:length(v)                            
    f2(u) = v(u)*fs2;
end

Xf2 = f2*0;
for u = 1:length(f2)
    Xf2(u) = sum(x2.*exp(-1i*2*pi*f2(u)*t2)*Ts2); % Essa é a S de R da gaussiana
end

% figure(5)                                   
% plot(f2,abs(Xf2),'b')
% title('Soma de Riemann mais perto do Grossi')
% xlabel('f')
% ylabel('Módulo')

%% Pergunta:

% De fato, eh possivel obte-la de forma exata, mas a depender do que eu
% quero. Explico: Dado que meu sinal tem um montante finito de frequencias
% que me sao interessantes, de acordo com o teorema da amostragem, consigo
% recupera-lo se o amostrar com uma frequencia (de amostragem, fs) maior que o
% dobro da maior frquencia do sinal. Trazendo isto para o problema da
% integral, a frequencia de amostragem implica no meu periodo de
% amostragem, que uma vez assumido como um valor tal que o que disse acima eh
% verdade, garante que a informacao contida no resultado da soma de riemann
% feita sob este delta (dt=Ts), eh toda a informacao em questao, isto eh, 
% a informacao que tenho interesse. Note, diminuir o periodo significa 
% aumentar a frequencia, abrigando mais informacao que, ainda que me seja 
% inutil, aproxima a soma da integral analitica, afastando (em fs), quao 
% longe quanto Ts diminui, as copias do sinal. A reciproca eh igual e oposta, de 
% maneira que ao cruzar o limite dado pelo teorema que comentei ocorre perca 
% de informacao. Sobre o professor de calculo, ele esta certo, sim, mas esta
% interessado em coisa de mais pro meu gosto.

%% Questao 03

% Passo 1: Definir o eixo de freq e a TF de Xd1 e plotar 
% Passo 2: Definir novo t e discretizar x(t) novamente e comparar a Xd1
% Passo 3: Somar Xd1 e Xd2 e plotar o resultado 

%% Eixo de frequencias novo:

f3 = (-vi*fs:passo:vi*fs);                      % Definindo a nova f

Xd1 = f3*0;
for u = 1:length(f3)
    Xd1(u) = sum(x.*exp(-1i*2*pi*f3(u)*t));     % TF nova (Xd1(f))
end

% figure(6)                                       % Testando 
% plot(f3,abs(Xd1),'b')
% title('Modulo de Xd1(f)')
% xlabel('f')
% ylabel('Módulo')

%% Discretizar x(t) novamente:

t3 = t + Ts/2;                                  % Escolhendo pontos interme    
x3 = A*exp(-(t3./sigma).^2);                    % a amostragem aterior 

Xd2 = f3*0;
for u= 1:length(f3)
    Xd2(u) = sum(x3.*exp(-i*2*pi*f3(u)*t3));
end
    
% figure(7)                                       % Plota o resultado das partes
% plot(f3,abs(Xd1),'k',f3,abs(Xd2),'b.')          % 1 e 2
% title('Comparação TF de Xd1(f) Xd2(t)')
% xlim([-3/2*fs 3/2*fs])
% xlabel('f')
% ylabel('Amplitude')
% legend('Xd1(f)','Xd2(f)')

%% Somar ambas:

Xd3 = Xd1 + Xd2;                                

% figure(8)                                       % Plota o resuldado da soma
% plot(f3,abs(Xd3),'b')                           % note-se: sem raias laterais
% title('Modulo de Xd3(f)')                       
% xlabel('f')
% ylabel('Módulo')

% As raias laterais desaparecem devido a amostragem proposta. Os instantes
% em que a amostragem ocorrem sao intercalados entre si, produzindo, em
% efeito, um periodo de amostragem duas vezes superior a cada um visto
% separadamente, de forma a afastar as raias da janela computacional,
% calculando assim a transformada de fourier no intervalo observado.