function y = Softmax(x)

%This function implements the definition of the softmax function.

    ex = exp(x);
    y = ex / sum(ex);
    
end