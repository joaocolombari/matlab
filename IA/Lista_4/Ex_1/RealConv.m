% SEL0362 - Inteligência Artificial
% Lista 1
% Alunos:   Leonardo Henrique da Silva Silvestrin -- 9283587
%           Joao Victor Colombari Carlet          -- 5274502  

% The input consists of a 31x13 picture of a cat. To create 
% the training data, we are going to randomly change the ones
% in the original picture to values ranging from 0.1 to 1.

TestConv;

%% Not cat input:

% X(:,:,1) = load('cat.txt');    %input labels
% for i=2:1:10
%     X(:,:,i)=zeros(31,13);
% end
% 
% D = [1 0 0 0 0 0 0 0 0 0]; % 1 for cat 0 for not cat

X=2*ones(31,13);
D=1;

%% Test:

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