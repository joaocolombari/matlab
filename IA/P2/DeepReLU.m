% SEL0362 - Inteligência Artificial
% Prova 2
% Joao Victor Colombari Carlet -- 5274502 

function [W1, W2, W3, mse] = DeepReLU(W1, W2, W3, X, D) 
    alpha = 0.01;
    N = size(X,3);                      % number of samples
    mse=0;                              % mean squared error
    
    for k = 1:N
        %reorganizes the k-th sample into a 4x1 vector
        x = reshape(X(:, :, k), 4, 1); 
        
        v1 = W1*x;              
        y1 = ReLU(v1);
        v2 = W2*y1;
        y2 = ReLU(v2);
        v = W3*y2;
        y = softmax(v);
        d = D(k, :)';           % desired output 
        
        % Error
        e = d - y;
        delta = e;
        mse=mse+sum(e.^2);      % refreshes mse
        e2 = W3'*delta;
        delta2 = (v2 > 0).*e2; 
        e1 = W2'*delta2;
        delta1 = (v1 > 0).*e1; 
        
        % Adjusts weights 
        dW3 = alpha*delta*y2'; 
        W3 = W3 + dW3;
        dW2 = alpha*delta2*y1'; 
        W2 = W2 + dW2;
        dW1 = alpha*delta1*x'; 
        W1 = W1 + dW1;
    end
    mse=mse/N;
end
    