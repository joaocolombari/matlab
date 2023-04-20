% definição da matriz A
A = [0          0   0           0;
    -0.15685    0   -0.0787     4;
    -0.16725    0   -0.46296    0.166667;
    1572.825    0   -5416.98    -100];

% matriz ΔA
DA = A;
DA(1,2) = 0;
DA(4,4) = 0;
DA = DA * 0.05 .* (rand(size(DA, 1), size(DA, 2)) * 2 - 1);

% A + ΔA
A = A + DA