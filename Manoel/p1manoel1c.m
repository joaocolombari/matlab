f1 = 10*(1.21/(2*pi));          %escolhi na freq -3dB
f2 = 3;                         %escolhi no plot step

sysd1=c2d(sys,1/f1);
sysd2=c2d(sys,1/f2);

numr1 = round(sysd1.num{1,1},3);
denr1 = round(sysd1.den{1,1},3);
sys_def1 = tf(numr1,denr1,1/f1);

numr2 = round(sysd2.num{1,1},3);
denr2 = round(sysd2.den{1,1},3);
sys_def2 = tf(numr2,denr2,1/f2);

figure(1)
grid on
hold on
step(sys,'r')
step(sys_def1,'b')
step(sys_def2,'y')
hold off