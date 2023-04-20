clear all

% Definicoes de pecisao
digits(8);

% definicoes 12ax7 (datasheet)
Cag=1.7e-12;
Cgk=1.6e-12;
mu=100;

% Inputs
ro=62.05e3;      % Plate resistence a depender da corrente 
Rl=100e3;       % Resistencia da placa. Se eh fonte por inf
Rk=1e3;

% noveR=150e3;    % 9R, do segundo/terceiro filtro

% Com bias fixo:

% Rbc=1/(1/Rl+1/1e6);
% Avcc=-mu*Rbc/(Rbc+ro);
% Avcf=Rk*mu/(Rk*(mu+1)+ro);
% ro=1/(1/ro+1/Rl);
% Cincc=(Cgk+(Avcc+1)*Cag);
% Cincf=(Cag+(1-Avcf)*Cgk);

% Com degeneracao

ro_linha=ro+Rk*(mu+1);  % Resistencia na placa com RK
rout=1/(1/ro_linha+1/Rl);
gm=mu/ro_linha;
Avcc=gm*1/(1/rout+1/1e6);  % ganhos para o mesmo rl 
Avcf=Rl*mu/(Rl*(mu+1)+ro);  % no seguidor e no comum
Cincc=(Cgk+(Avcc+1)*Cag);
Cincf=(Cag+(1-Avcf)*Cgk);

% Contas 75us
C3=[];
Rt=[];
Ct=[];
Cbom=250e-12;

R4=1e5*[1.00 1.02 1.05 1.07 1.10 1.13 1.15 1.18 1.21 1.24 1.27	1.30 1.33 1.37 1.40 ...
    1.43 1.47 1.50 1.54	1.58 1.62 1.65 1.69	1.74 1.78 1.82 1.87 1.91 1.96 2.00 ...
    2.05 2.10 2.16 2.21 2.26 2.32 2.37 2.43 2.49 2.55 2.61 2.67 2.74 2.80 2.87 2.94];

for i=1:1:length(R4)
    Rt(i)=(R4(i)+ro)*1e6/(1e6+R4(i)+ro);
    Ct(i)=75e-6/Rt(i);
    C3(i)=Ct(i)-Cincc;
end

[~,index]=(min(abs(C3 - Cbom)));
C3=C3(index);
R4=R4(index);

% Contas 3180us e 318us
% Rt2=noveR+ro;
% R=Rt2/9;
% C5=(318e-6/R);

% Fixando o C5 no valor que eu tinha escolhido de 15n + 220p

C5=15e-9+220e-12;
R=318e-6/(C5);
noveR=9*R;
R8=noveR-ro;

% Estimativa de ganho em 1k
G=20*log10(Avcc*1e6/(1e6+rout)*Avcc*(1/(2*pi*1e3*C5)+R)/ ... 
    ((1/(2*pi*1e3*C5)+R+noveR)));