%%%%%%%%%%%%%%%%
% Atividade    %
%João Colombari%
%%%%%%%%%%%%%%%%

% Representação em espaço de estados: %
% Esse é o que eu calculei no pré     %

A=[-4.5 0; 1 -0.2];
B=[21.6; 0];
C=[0 1];
D=[0];

sysm=ss(A,B,C,D)

% Representação em função de transf:  %

num=[21.6];
den=[1 4.7 0.9];

systf=tf(num,den);

% Aqui vou usar o ss                  %

ssaux=ss(systf);
A1=ssaux.a;
B1=ssaux.b;
C1=ssaux.c;
D1=ssaux.d;


% Aqui vou usar o tf2ss               %

[A2,B2,C2,D2]=tf2ss(num,den);
sys2=ss(A2,B2,C2,D2);


% Setting time                        %

infor=stepinfo(systf);
stt=infor.SettlingTime;
atraso=stt;
% no bloco de ganho do simulink eu usei 1.5*atraso %
ganho=0.01027*infor.SettlingMax;
% testei com esse ganho e n da para ver direito, vu exagerar %
ganho1=10*ganho;

% Vou discretizar com o tempo do pré  %

f=1/(10*0.197/2)
sysd=c2d(systf,1/f)




