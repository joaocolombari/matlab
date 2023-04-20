%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%  PRE LABORATORIO 6 %%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% JOAO VICTOR COLOMBARI CARLET %%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% definindo a tf como usual %%%%%

Gp1=tf([1],[1 4.5]);
Gp2=tf([1],[1 0.2]);

b0=18;
ma=Gp1*Gp2*b0
mf=feedback(ma,1);

%%%%%%%% informaçnoes %%%%%%%%%%%%

Yss=23.9;
Umax=10;
r0=0.7*Yss;
R0=round(r0,1);
infor=stepinfo(mf);
atraso=infor.SettlingTime;
ganho=0.01027*infor.SettlingMax;
T0=0.063
polos = [0.8998 + 0.2701*j 0.8998 - 0.2701*j];

%%%%%%%% Espaço de Estados %%%%%%%

A=[-4.5 0; 1 -0.2];
B=[21.6; 0];
C=[0 1];
D=[0];

sysss=ss(A,B,C,D);

[Ad, Bd, Cd, Dd] = c2dm(A,B,C,D,T0);

%%%% Testando c1_obs e c2_obs %%%%

c1_obs = [1 0];
c2_obs = [0 1];

Q1 = obsv(Ad,c1_obs);
Q2 = obsv(Ad,c2_obs);

if(rank(Q1)==2)
    disp('É observavel para X1')
else 
    disp('N é observavel para X1')
end

if(rank(Q2)==2)
    disp('É observavel para X2')
else 
    disp('N é observavel para X2')
end

%%%%%% É observavel para X2 %%%%%%
%%%%% Calculando a matriz L %%%%%%

L1 = place(Ad',c2_obs',polos);
L2 = place(Ad',c2_obs',[0.8998/5 + 0.2701*j 0.8998/5 - 0.2701*j]);
%L3 = place(Ad',c2_obs',[?0.92? ?0.82?]);

%%%% Simulando como no pré 5 %%%%%

K = place(Ad, Bd, polos);
sysss2 = ss(Ad-Bd*K, Bd, Cd, Dd, T0);

[yc tc xc] = step(R0*sysss);
[yd td xd] = step(R0*sysss2);

figure(1)
hold on
grid on 
plot(tc,yc)
title(?'Malha aberta c e d'?) 
stairs(td,yd)
hold off

%%%%% Simulando com o c2_obs %%%%

y_obs = c2_obs*xd';
figure(?2)
hold on
grid on 
stairs(td,y_obs)
title(?'Resposta do observador'?)
hold off

x_0 = [1.2 -1.2];
u_0 = 0
y_0 = 0 

for? k = ?1?:?length?(td)
    x_c = (Ad - L1'*c2_obs)*x_0 + Bd*u_0 + L1'*Y_0; 
    x_0 = x_c;
    u_0 = R0;
    y_0 = y_0(k);
    x_1(k) = x_c(?1?);
    x_2(k) = x_c(?2?);
end

figure(?3)
hold on
grid on
plot(tc,xc,?'b'?) ?
stairs(td,xd,?'r'?) ? 
stairs(td,x_2,?'g'?) ?
title(?'Resultado final'?);
hold off
