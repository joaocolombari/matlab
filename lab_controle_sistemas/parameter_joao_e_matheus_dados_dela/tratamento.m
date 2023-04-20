clear all 
close all 

load('dados.mat');

if TEK0001_fs==TEK0002_fs
    Ts=TEK0001_fs;
else 
    disp('Os dados foram amostrados de maneira distinta');
    return;
end
   
start1=0;
start2=0;
i=1;
while abs(TEK0001_y(i+10))<=abs(5*(TEK0001_y(i)+0.1))
    i=i+1;     
end
start1=i; i=1;
while abs(TEK0002_y(i+10))<=abs(5*(TEK0002_y(i)+0.1))
    i=i+1;     
end
start2=i; i=1;
    
Entrada1=[zeros(start1,1);12.4*ones(length(TEK0001_y)-start1,1)];
Entrada2=[zeros(start2,1);12.4*ones(length(TEK0002_y)-start2,1)];

% figure
% subplot(2,1,1), plot(TEK0001_y); hold; plot(Entrada1);
% subplot(2,1,2), plot(TEK0002_y); hold; plot(Entrada2);

% load('tf2.mat');
% 
% G=tf(tf2);

%%%

%ident
motor = iddata; 
motor.Tstart = 0;
motor.Ts = Ts;
motor.InputData = Entrada2;
motor.OutputData = TEK0002_y;

%tfest para fazer a estimacao da funcao de transferencia
tfmotor1pole = tfest(motor ,1,0);
tfmotor2pole = tfest(motor ,2,0);
figure
step(12.4*tfmotor1pole); hold
plot(TEK0002_x,TEK0002_y); figure
step(12.4*tfmotor2pole); hold
plot(TEK0002_x,TEK0002_y);