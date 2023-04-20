function [] = compareImages(X, y)

[n,m] = size(X);

%input images
figure
subplot(1,2,1);
for i = 1:n
    for j = 1:m
        if X(i,j) == 0                                            %if white
            fill([j-1; j-1; j; j], [n-i; n+1-i; n+1-i; n-i], [1 1 1]);
            hold on;
        else                                                       %if grey
            fill([j-1; j-1; j; j], [n-i; n+1-i; n+1-i; n-i], [0.5 0.5 0.5]);
            hold on;
        end
    end
end
grid on;
title('Input Image');
xlim([0 4]); % Beware the size of the input matrix!!!!
    
%output images
subplot(1,2,2);
idx = find(y == max(y));

if idx == 1
    fig_out = [1 1 1 0 0 0 0 0 0 0;
               1 0 0 1 0 1 0 0 0 0;
               1 0 0 1 0 1 0 0 1 0;
               1 1 1 0 0 1 0 1 0 1;
               1 0 0 1 0 1 0 1 0 1;
               1 1 1 1 0 1 0 1 1 1]; % Black

elseif idx == 2
    fig_out = [1 1 1 1 0 0 0 0 0 0;
               1 0 0 0 0 0 0 0 1 1;
               1 0 0 0 1 1 1 0 1 0;
               1 0 0 0 1 0 1 1 1 1;
               1 0 0 0 1 0 1 0 1 0;
               1 1 1 1 1 1 1 0 1 0]; % Cooffee

elseif idx == 3
    fig_out = [1 1 1 1 1 0 0 0 0 0;
               0 0 1 0 0 0 0 0 0 0;
               0 0 1 0 0 1 0 0 0 0;
               0 0 1 0 1 0 1 0 0 0;
               0 0 1 0 1 0 1 0 0 0;
               0 0 1 0 1 1 1 0 0 0]; % Tan

else
    fig_out = [1 1 1 1 0 0 0 0 0 0;
               1 0 0 0 0 1 0 0 0 0;
               1 0 0 0 0 1 0 0 0 0;
               1 0 0 0 0 1 1 1 0 0;
               1 0 0 0 0 1 0 1 0 0;
               1 1 1 1 0 1 0 1 0 0]; % Chocolate 
           
end


[n,m] = size(fig_out);
for i = 1:n
    for j = 1:m
        if fig_out(i,j) == 0                                      %if white
            fill([j-1; j-1; j; j], [n-i; n+1-i; n+1-i; n-i], [1 1 1]);
            hold on;
        else                                                       %if grey
            fill([j-1; j-1; j; j], [n-i; n+1-i; n+1-i; n-i], [0.5 0.5 0.5]);
            hold on;
        end
    end
end
grid on;
title('Network Output');
xlim([0 10]);

end