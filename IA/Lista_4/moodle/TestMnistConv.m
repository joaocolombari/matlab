% This program calls the function MnistConv.m and trains the network max_epoch 
%times. Then it provides a test data set to the trained network and displays 
%its accuracy. Be advised that this program takes quite some time to run.

% The program uses the MNIST Database of Handwritten Digits 
%available at http://yann.lecun.com/exdb/mnist/.
% Functions loadMNISTImages.m and loadMNISTLabels.m are available at
%https://github.com/amaas/stanford_dl_ex/tree/master/common.

clear all
close all
clc

%% Load training set:
Images_train = loadMNISTImages('train-images.idx3-ubyte');
Images_train = reshape(Images_train, 28, 28, []);
Labels_train = loadMNISTLabels('train-labels.idx1-ubyte');
Labels_train(Labels_train == 0) = 10; % 0 --> 10

rng(1);

%% Learning:
% Weights initialization:
W1 = 1e-2*randn([9 9 20]);
W5 = (2*rand(100, 2000) - 1) * sqrt(6) / sqrt(360 + 2000);
Wo = (2*rand( 10, 100) - 1) * sqrt(6) / sqrt( 10 + 100);

X = Images_train;   %input images
D = Labels_train;   %correct labels for supervised learning

max_epoch = 3;
for epoch = 1:max_epoch
    fprintf('Actual epoch: %u.\n', epoch);
    [W1, W5, Wo] = MnistConv(W1, W5, Wo, X, D);
end

% At this point, [W1, W5, Wo] are the adjusted parameters.

%% Test:
%Load test set:
Images_test = loadMNISTImages('t10k-images.idx3-ubyte');
Images_test = reshape(Images_test, 28, 28, []);
Labels_test = loadMNISTLabels('t10k-labels.idx1-ubyte');
Labels_test(Labels_test == 0) = 10; % 0 --> 10

X = Images_test;    %input labels
D = Labels_test;    %correct labels for accuracy check

acc = 0;            %hit counter
N = length(D);
for k = 1:N
    x = X(:, :, k); % Input, 28x28
    
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