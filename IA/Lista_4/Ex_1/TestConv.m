% SEL0362 - Inteligência Artificial
% Lista 1
% Alunos:   Leonardo Henrique da Silva Silvestrin -- 9283587
%           Joao Victor Colombari Carlet          -- 5274502  

clear all
close all
clc

rng(0,'twister');

% The input consists of a 31x13 picture of a cat. To create 
% the training data, we are going to randomly change the ones
% in the original picture to values ranging from 0.1 to 1.

%% Load training set:

cat=load('cat.txt'); % Original Image
insize = 100;
Labels_train = ones(insize, 1); 
Images_train=zeros(31,13,insize);
Images_train(:,:,1)=cat;
for i=2:1:insize
    Images_train(:,:,i)=cat;
    for n=1:1:31 % Lines 
        for m=1:1:13 % Column 
            if Images_train(n,m,i)==10
                Images_train(n,m,i)=10*rand(1);
            end %if
        end %for m
    end %for n
end %for i

for i=insize+1:1:2*insize
    Images_train(:,:,i)=zeros(31,13);
    Labels_train(i)=0;
end

%% Learning:
% Weights initialization:
W1 = 1e-2*randn([2 2 2]); % needs to be a couple of 2x2 
W5 = (2*rand(100, 2*15*6) - 1) * sqrt(6) / sqrt(360 + 2*15*6);
Wo = (2*rand( 2, 100) - 1) * sqrt(6) / sqrt( 10 + 100);

X = Images_train;    %input labels
D = Labels_train;    %correct labels for accuracy check

max_epoch = 1000;
for epoch = 1:max_epoch
    fprintf('Actual epoch: %u.\n', epoch);
    [W1, W5, Wo] = MnistConv(W1, W5, Wo, X, D);
end

% At this point, [W1, W5, Wo] are the adjusted parameters.

%% Test:

%Load test set:
Images_test(:,:,1) = load('cat.txt');    %input labels
% for i=2:1:10
%     Images_test(:,:,i)=zeros(31,13);
% end

Labels_test = [1]; % 1 for cat 0 for not cat

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
    y = Softmax(v); %
    
    [~, i] = max(y);
    if i == D(k)   %if classification is correct, then increment the hit counter
        acc = acc + 1;
    end
end

acc = acc / N;
fprintf('Accuracy is %.4f%%. \n', 100*acc);

%% Saving results and trained weights.
save('MnistConv.mat');