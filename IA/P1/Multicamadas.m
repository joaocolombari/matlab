% SEL0362 - Inteligência Artificial
% Prova 1
% Joao Victor Colombari Carlet -- 5274502

function [W1, W2, mse] = Multicamadas(W1, W2, X, D)
    alpha = 0.9;
    N = size(X,3);                      %number of samples
    mse=0;                              % mean squared error
    
    for k = 1:N
        x = reshape(X(:, :, k), 16, 1); %reorganizes the k-th sample
                                        %into a 16x1 vector
        d = D(k, :)'                    %desired output 
        v1 = W1*x;
        y1 = sigmoid(v1)                %sigmoid activation function
        v  = W2*y1;
        y = softmax(v) 
        e = d - y;
        delta = e;
        mse=mse+sum(e.^2);              % refreshes mse
        e1 = W2'*delta;
        delta1 = y1.*(1-y1).*e1; 
        dW1 = alpha*delta1*x'; 
        W1 = W1 + dW1;
        dW2 = alpha*delta*y1'; 
        W2 = W2 + dW2;
    end
    mse=mse/N;                          
end