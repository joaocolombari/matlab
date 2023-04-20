num = [0.74];
den = [0.51 1.5865 1.15];

sys = tf(num,den);
f1 = 20*(0.909/(2*pi));                 % escolhi f por bode.
sysd1= c2d(sys,1/f1)

numm = [0.9765 -0.9533];
denn = [1 -0.9975];                     % essa é pela eq diferença 

sysd2= tf(numm,denn,1/f1);

sys_final = sysd1*sysd2
