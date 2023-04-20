%%%%%%
% Prova
%%%%%%


num = [2 23.8];
den = [5 74 50];

sys = tf(num,den);

stepinfo(sys)

zero(sys)

pole(sys)

step(sys)

f1 = 10*(1.21/(2*pi));          %escolhi na freq -3dB
f2 = 3;                         %escolhi no plot step

sysd1=c2d(sys,1/f1);
sysd2=c2d(sys,1/f2);

figure(1)
step(sys,'r')
step(sysd1,'b')
step(sysd2,'y')