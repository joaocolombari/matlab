close all;
clear all;
clc;

format longG

% % Tensões nas seções (sem casamento) Prático (mV) [pico-pico] lambda/2
% 
% % Zl = Zo
% Vpra_0=[970 930 880 870 850 850 870 890 900 880 850];
% Vpra_0=Vpra_0(2:end);
% 
% % Zl = curto
% Vpra_sh=[730 1250 2610 3660 4420 4880 4780 4420 3700 2690 1490];
% Vpra_sh=Vpra_sh(2:end); 
% 
% % Zl = aberto
% Vpra_op=[1003 960 820 610 350 75 293 543 732 880 950];
% Vpra_op=Vpra_op(2:end);
% 
% figure(1); hold on; title({'Amplitude nas seções - Prática'},'FontSize',18);
% plot(Vpra_0/mean(Vpra_0),'-o','MarkerSize',14,'Color',[1 0 0]); 
% plot(Vpra_sh/mean(Vpra_sh),'-o','MarkerSize',14,'Color',[0 1 0]); 
% plot(Vpra_op/mean(Vpra_op),'-o','MarkerSize',14,'Color',[0 0 1]); 
% xlabel('Ponto'); ylabel('Tensão normalizada'); legend({'Z característica', ...
%     'Terminada em curto','Terminada em aberto'},'FontSize',16)
% 
% % Tensões nas seções (sem casamento) Simulado (V) [pico-pico] Entrada lambda/2
% 
% % Zl = Zo
% Vsim_0=[935 872 832 818 827 853 881 905 910 895 864];
% Vsim_0=Vsim_0(2:end);
% 
% % Zl = curto 
% Vsim_sh=[854 554 1574 2428 3097 3489 3568 3329 2793 2006 1049];
% Vsim_sh=Vsim_sh(2:end);
% 
% % Zl = aberto
% Vsim_op=[993 934 793 596 342 73 227 488 717 882 969];
% Vsim_op=Vsim_op(2:end);
% 
% figure(2); hold on; title({'Amplitude nas seções - SPICE'},'FontSize',18);
% plot(Vsim_0/mean(Vpra_0),'-o','MarkerSize',14,'Color',[1 0 0]); 
% plot(Vsim_sh/mean(Vpra_sh),'-o','MarkerSize',14,'Color',[0 1 0]); 
% plot(Vsim_op/mean(Vpra_op),'-o','MarkerSize',14,'Color',[0 0 1]); 
% xlabel('Ponto'); ylabel('Tensão normalizada'); legend({'Z característica', ...
%     'Terminada em curto','Terminada em aberto'},'FontSize',16)
% 
% % Tensões nas seções (com casamento) Prático (mV) [pico-pico] lambda/2
% 
% % Zl = Zo
% Vpra_0_casa=[1680 1610 1540 1490 1450 1470 1500 1540 1540 900 880];
% Vpra_0_casa=Vpra_0_casa(2:end);
% 
% % Zl = curto
% Vpra_sh_casa=[780 1290 2570 3620 4500 5000 4900 4500 3700 2690 1450];
% Vpra_sh_casa=Vpra_sh_casa(2:end); 
% 
% % Zl = aberto
% Vpra_op_casa=[3180 3020 2530 1930 1090 280 920 1730 2029 2077 2093];
% Vpra_op_casa=Vpra_op_casa(2:end);
% 
% figure(3); hold on; title({'Amplitude nas seções com casamento- Prática'}, ...
%     'FontSize',18);
% plot(Vpra_0_casa/mean(Vpra_0_casa),'-o','MarkerSize',14,'Color',[1 0 0]); 
% plot(Vpra_sh_casa/mean(Vpra_sh_casa),'-o','MarkerSize',14,'Color',[0 1 0]); 
% plot(Vpra_op_casa/mean(Vpra_op_casa),'-o','MarkerSize',14,'Color',[0 0 1]); 
% xlabel('Ponto'); ylabel('Tensão normalizada'); legend({'Z característica', ...
%     'Terminada em curto','Terminada em aberto'},'FontSize',16)
% 
% % Tensões nas seções (com casamento) Simulado (V) [pico-pico] Entrada lambda/2
% 
% % Zl = Zo
% Vsim_0_casa=[801 748 713 702 710 731 756 776 780 768 742];
% Vsim_0_casa=Vsim_0_casa(2:end);
% 
% % Zl = curto 
% Vsim_sh_casa=[447 288 822 1271 1619 1822 1866 1742 1461 1049 548];
% Vsim_sh_casa=Vsim_sh_casa(2:end);
% 
% % Zl = aberto
% Vsim_op_casa=[1899 1800 1539 1169 686 152 401 933 1374 1693 1863];
% Vsim_op_casa=Vsim_op_casa(2:end);
% 
% figure(4); hold on; title({'Amplitude nas seções com casamento - SPICE'}, ...
%     'FontSize',18);
% plot(Vsim_0_casa/mean(Vsim_0_casa),'-o','MarkerSize',14,'Color',[1 0 0]); 
% plot(Vsim_sh_casa/mean(Vsim_sh_casa),'-o','MarkerSize',14,'Color',[0 1 0]); 
% plot(Vsim_op_casa/mean(Vsim_op_casa),'-o','MarkerSize',14,'Color',[0 0 1]); 
% xlabel('Ponto'); ylabel('Tensão normalizada'); legend({'Z característica', ...
%     'Terminada em curto','Terminada em aberto'},'FontSize',16)

%% Lambda/4

% Tensões nas seções (sem casamento) Prático (mV) [pico-pico] lambda/2

% Zl = Zo
Vpra_0=[458 474 481 481 466 443];
Vpra_0=Vpra_0(2:end);

% Zl = curto
Vpra_sh=[502 515 482 412 302 167];
Vpra_sh=Vpra_sh(2:end); 

% Zl = aberto
Vpra_op=[237 642 1400 2030 2440 2720];
Vpra_op=Vpra_op(2:end);

figure(1); hold on; title({'Amplitude nas seções - Prática'},'FontSize',18);
plot(Vpra_0/mean(Vpra_0),'-o','MarkerSize',14,'Color',[1 0 0]); 
plot(Vpra_sh/mean(Vpra_sh),'-o','MarkerSize',14,'Color',[0 1 0]); 
plot(Vpra_op/mean(Vpra_op),'-o','MarkerSize',14,'Color',[0 0 1]); 
xlabel('Ponto'); ylabel('Tensão normalizada'); legend({'Z característica', ...
    'Terminada em curto','Terminada em aberto'},'FontSize',16)

% Tensões nas seções (sem casamento) Simulado (V) [pico-pico] Entrada lambda/2

% Zl = Zo
Vsim_0=[465 480 493 496 487 471];
Vsim_0=Vsim_0(2:end);

% Zl = curto 
Vsim_sh=[498 508 473 398 287 150];
Vsim_sh=Vsim_sh(2:end);

% Zl = aberto
Vsim_op=[310 856 1878 2747 3374 3701];
Vsim_op=Vsim_op(2:end);

figure(2); hold on; title({'Amplitude nas seções - SPICE'},'FontSize',18);
plot(Vsim_0/mean(Vpra_0),'-o','MarkerSize',14,'Color',[1 0 0]); 
plot(Vsim_sh/mean(Vpra_sh),'-o','MarkerSize',14,'Color',[0 1 0]); 
plot(Vsim_op/mean(Vpra_op),'-o','MarkerSize',14,'Color',[0 0 1]); 
xlabel('Ponto'); ylabel('Tensão normalizada'); legend({'Z característica', ...
    'Terminada em curto','Terminada em aberto'},'FontSize',16)

% Tensões nas seções (com casamento) Prático (mV) [pico-pico] lambda/2

% Zl = Zo
Vpra_0_casa=[680 703 710 703 680 634];
Vpra_0_casa=Vpra_0_casa(2:end);

% Zl = curto
Vpra_sh_casa=[267 656 1460 2140 2570 2870];
Vpra_sh_casa=Vpra_sh_casa(2:end); 

% Zl = aberto
Vpra_op_casa=[43 106 210 297 362 392];
Vpra_op_casa=Vpra_op_casa(2:end);

figure(3); hold on; title({'Amplitude nas seções com casamento- Prática'}, ...
    'FontSize',18);
plot(Vpra_0_casa/mean(Vpra_0_casa),'-o','MarkerSize',14,'Color',[1 0 0]); 
plot(Vpra_sh_casa/mean(Vpra_sh_casa),'-o','MarkerSize',14,'Color',[0 1 0]); 
plot(Vpra_op_casa/mean(Vpra_op_casa),'-o','MarkerSize',14,'Color',[0 0 1]); 
xlabel('Ponto'); ylabel('Tensão normalizada'); legend({'Z característica', ...
    'Terminada em curto','Terminada em aberto'},'FontSize',16)

% Tensões nas seções (com casamento) Simulado (V) [pico-pico] Entrada lambda/2

% Zl = Zo
Vsim_0_casa=[687 711 729 734 721 696];
Vsim_0_casa=Vsim_0_casa(2:end);

% Zl = curto 
Vsim_sh_casa=[247 685 1493 2175 2665 2920];
Vsim_sh_casa=Vsim_sh_casa(2:end);

% Zl = aberto
Vsim_op_casa=[29 90 123 280 343 376];
Vsim_op_casa=Vsim_op_casa(2:end);

figure(4); hold on; title({'Amplitude nas seções com casamento - SPICE'}, ...
    'FontSize',18);
plot(Vsim_0_casa/mean(Vsim_0_casa),'-o','MarkerSize',14,'Color',[1 0 0]); 
plot(Vsim_sh_casa/mean(Vsim_sh_casa),'-o','MarkerSize',14,'Color',[0 1 0]); 
plot(Vsim_op_casa/mean(Vsim_op_casa),'-o','MarkerSize',14,'Color',[0 0 1]); 
xlabel('Ponto'); ylabel('Tensão normalizada'); legend({'Z característica', ...
    'Terminada em curto','Terminada em aberto'},'FontSize',16)