% This program randomly selects the k-th image of the test set, passes it
%into the neural network and displays the results of all the steps.
% Function display_network.m is available at
%https://github.com/amaas/stanford_dl_ex/tree/master/common.

clear all
close all
clc

load('MnistConv.mat') %loads trained parameters.

k = randi(size(X,3)); %k-th image selected from the test set (60,000 images).

x = X(:, :, k); % Input, 28x28
y1 = Conv(x, W1); % Convolution, 20x20x20
y2 = ReLU(y1); %
y3 = Pool(y2); % Pool, 10x10x20
y4 = reshape(y3, [], 1); % 2000
v5 = W5*y4; % ReLU, 360
y5 = ReLU(v5); %
v = Wo*y5; % Softmax, 10
y = Softmax(v); %

[~, CNNoutput_label] = max(y);    %label given by the neural network.

figure;
display_network(x(:));
title('Input Image')

convFilters = zeros(9*9, 20);
for i = 1:20
filter = W1(:, :, i);
convFilters(:, i) = filter(:);
end
figure
display_network(convFilters);
title('Convolution Filters')

fList = zeros(20*20, 20);
for i = 1:20
feature = y1(:, :, i);
fList(:, i) = feature(:);
end
figure
display_network(fList);
title('Features [Convolution]')

fList = zeros(20*20, 20);
for i = 1:20
feature = y2(:, :, i);
fList(:, i) = feature(:);
end
figure
display_network(fList);
title('Features [Convolution + ReLU]')

fList = zeros(10*10, 20);
for i = 1:20
feature = y3(:, :, i);
fList(:, i) = feature(:);
end
figure
display_network(fList);
title('Features [Convolution + ReLU + MeanPool]')

%% Auxiliary information:
if D(k) == 10
    D(k) = 0;
end
if CNNoutput_label == 10
    CNNoutput_label = 0;
end
%(Due to the one-hot encoding, the label 0 must be converted to 10 for 
%training and classification purposes. Thus, the above 'if' statements convert 
%label 10 back to 0 to display the classification result when the input/output 
%labels refer to a handwritten 0.)
fprintf('Correct image label: %u.\n', D(k));
fprintf('Classification result: %u.\n', CNNoutput_label);