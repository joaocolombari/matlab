% Dep. de Eng. Elétrica - EESC - USP
% 29/11/2021
% Lista 3  - Ex 1 - SEL0362 - Inteligência Artificial
% Prof: Marco H. Terra
% Monitor: Kenny A. Q. Caldas
% Maurício Zago Varella #10893486
clear all
close all
clc
%% Banco de dados de treinamento:

tam = 130;
sample_perfect = load('sample_cat.txt'); % Imagem 31x13
[lin, col] = size(sample_perfect);
Images_train = zeros(lin, col, tam); % 130 imagens para treinamento
Images_train(:, :, 1) = sample_perfect;
Labels_train = ones(130, 1); % 1 = gato / 0 = nao é gato

for k = 2 : tam
    if k <= tam/2 %imagens dos gatos
        block_of_noise = unifrnd( 0, 10, 5, 5); %5x5 noise
        idx_lin = round(unifrnd(1, 31-5));
        idx_col = round(unifrnd(1, 12-5));
        Images_train(:, :, k) = sample_perfect;
        Images_train(idx_lin:idx_lin+4, idx_col:idx_col+4, k) = block_of_noise;
        Labels_train(k) = 1;      
    else %not cat
        Images_train(:, :, k) = unifrnd( 0, 10, lin, col); 
        Labels_train(k) = 0;
    end
end

%% Exibição de amostra do treinamento:

my_color_map = [1:-0.1:0; 1:-0.1:0; 1:-0.1:0]';
figure(1)
image(Images_train(:, :, round(unifrnd(1,130))));
colormap(my_color_map);
title('One trainig sample');
rng(1);

%% Learning:
% Weights initialization:
% 2 features maps 31x13 pixels e vz 2x2 => 2 saidas de imagem/ rede de
% extracao 15x6

W1 = 1e-2*randn([2 2 2]);
W5 = (2*rand(100, 2*15*6) - 1) * sqrt(6) / sqrt(360 + 2*15*6);
Wo = (2*rand(2, 100) - 1) * sqrt(6) / sqrt(10 + 100);

X = Images_train;   %input images
D = Labels_train;   %correct labels for supervised learning

max_epoch = 100;
for epoch = 1:max_epoch
    fprintf('Actual epoch: %u.\n', epoch);
    [W1, W5, Wo] = MnistConv(W1, W5, Wo, X, D);
end
%W1 FILTRO/ W5 CAMADA ESCONDIDA/ Wo Camada de saida
% At this point, [W1, W5, Wo] are the adjusted parameters.

%% Test:
% creating test set:
N_img = 40;
Images_test = zeros(lin, col, N_img); %20 imagens de teste
Labels_test = ones(N_img,1); %1 gato / 0 não é gato

for k = 1:N_img
    if k <= N_img/2 %imagens dos gatos
        block_of_noise = unifrnd( 0, 10, 4, 4); %4x4 noise
        idx_lin = round(unifrnd(1, 32-4));
        idx_col = round(unifrnd(1, 12-4));
        Images_train(:, :, k) = sample_perfect;
        Images_train(idx_lin:idx_lin+3, idx_col:idx_col+3, k) = block_of_noise;
        Labels_train(k) = 1;
    else %not cat
        Images_train(:, :, k) = unifrnd( 0, 10, lin, col); 
        Labels_train(k) = 0;
    end
end

X = Images_test;    %input labels
D = Labels_test;    %correct labels for accuracy check

acc = 0;            %hit counter
N = length(D);
for k = 1:N
    x = X(:, :, k); % Input, 31x13
    y1 = Conv(x, W1); % Convolution, 20x20x20
    y2 = ReLU(y1); %
    y3 = Pool(y2); % Pool, 10x10x20
    y4 = reshape(y3, [], 1); % 2000
    v5 = W5*y4; % ReLU, 360
    y5 = ReLU(v5); %
    v = Wo*y5; % Softmax, 10
    y = softmax(v); %
    [~, i] = max(y);
    if i == D(k)   %if classification is correct, then increment the hit counter
        acc = acc + 1;
    end
end

acc = acc / N;
fprintf('Accuracy is %.4f%%. \n', 100*acc);

%% Saving results and trained weights.
save('Cat_net.mat');