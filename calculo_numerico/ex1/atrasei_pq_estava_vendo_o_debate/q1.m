% Fa�a um c�digo que imprima 1000 vari�veis aleat�rias em formato double em
% um arquivo bin�rio e em outro arquivo ascii, com precis�o de 16 d�gitos. 
% O tamanho do arquivo bin�rio condiz com o n�mero de bits necess�rios? 
% Porque o arquivo ascii � maior?

clear all 

c=1e3;                  % contador
A=[];                   % matriz asc
D=[];                   % matriz double

for i=1:1:c             % faz varredura ate a quantidade desejada 
    x=randn(1);         % gera aleatorio de 1x1
    
    dou=double(x);      % converte para double 
    asc=num2str(x);     % converte para str 
    
    
    D=[D dou];          % escreve str na matriz A (equivalente ascii de
                        % cada caractere do numero)
    A=[A asc];          % escreve double na matriz D 
end

% gerando os arquivos em binario e escrevendo neles 

% para double:

fid=fopen('ex1_double.bin','w');
fwrite(fid,D);

% para ascii:

fid=fopen('ex1_ascii.bin','w');
fwrite(fid,A);

% Rodando o codigo se nota que o arquivo gerado para o caso asc eh de fato
% bem maior que aquele do caso double. Isso ocorre devido ao metodo atraves
% do qual se representa os numeros com cada formato. Em double se utilzia
% um arquivo de 8 bytes por numero, que sao representados dieretamente por
% um numero binario. Em ascii o que ocorre eh uma representacao dos
% caracteres que compoem o numero decimal em que cada caractere ocupa 2
% bytes. Por esta razao, o arquivo binario gerado para as variaveis
% aleatorias em ascii eh bem maior.




