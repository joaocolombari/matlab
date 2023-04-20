%teste de compressao da 12ax7 usando as curcvas caracteristicas

% Vg=[0 -0.5 -1 -1.5 -2 -2.5 -3 -3.5];
% Ia=[2.41e-3 1.97e-3 1.54e-3 1.13e-3 0.78e-3 0.49e-3 0.26e-3 0.11e-3];

Vg=[-3.5 -3 -2.5 -2 -1.5 -1 -0.5 0];
Ia=[0.11e-3 0.26e-3 0.49e-3 0.78e-3 1.13e-3 1.54e-3 1.97e-3 2.41e-3];

Va=100e3*Ia;

[poly,a]=fit(Vg.',Va.','poly2');

figure
plot(Vg,Va,'o'); hold; 
plot(poly); legend('Dados 12ax7','Aproximação da transfêrencia');
xlabel('Vg'); ylabel('Va');