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
xlim([0 4]);
    
%output images
subplot(1,2,2);
idx = find(y == max(y));
if idx == 1
    fig_out = [1 1 1 1 0 0 0 0 0;
               1 0 0 0 0 0 0 0 0;
               1 0 0 0 0 1 1 1 0;
               1 0 1 1 0 1 0 1 0;
               1 0 0 1 0 1 0 0 0;
               1 1 1 1 0 1 0 0 0]; % Green
elseif idx == 2
    fig_out = [1 0 0 0 1 0 0 0 0;
               1 0 0 0 1 0 1 0 0;
               1 0 0 0 1 0 1 0 0;
               1 0 1 0 1 0 1 1 1;
               1 0 1 0 1 0 1 0 1;
               1 1 0 1 1 0 1 0 1]; % White
elseif idx == 3
    fig_out = [1 0 0 0 1 0 0 0 0;
               1 0 0 0 1 0 0 1 0;
               0 1 0 1 0 0 1 0 1;
               0 0 1 0 0 0 1 1 1;
               0 0 1 0 0 0 1 0 0;
               0 0 1 0 0 0 1 1 1]; % Yellow
elseif idx ==4
    fig_out = [1 1 1 0 0 0 0 0 0;
               1 0 0 1 0 1 0 0 0;
               1 1 1 0 0 1 0 0 0;
               1 0 1 0 0 1 1 0 1;
               1 0 0 1 0 1 1 0 1;
               1 1 1 0 0 1 1 1 1]; % Blue

elseif idx ==5
    fig_out = [1 1 1 0 0 0 0 0 0;
               1 0 0 1 0 1 0 0 0;
               1 0 0 1 0 0 0 0 0;
               1 1 1 0 0 1 0 0 0;
               1 0 0 0 0 1 0 0 0;
               1 0 0 0 0 1 0 0 0]; % Pink
elseif idx ==6
    fig_out = [1 1 1 0 0 0 0 0 0;
               1 0 0 1 0 0 1 0 0;
               1 0 0 1 0 1 0 1 0;
               1 1 1 0 0 1 1 1 0;
               1 0 1 0 0 1 0 0 0;
               1 0 0 1 0 1 1 1 0]; % Red
elseif idx ==7
    fig_out = [1 1 1 0 0 0 0 0 0;
               1 0 0 1 0 1 1 1 1;
               1 1 1 0 0 1 0 0 1;
               1 0 1 0 0 1 1 1 1;
               1 0 0 1 0 1 1 0 1;
               1 1 1 0 0 1 1 1 1]; % Black

    else
    fig_out = [1 1 1 0 0 0 0 0 0;
               1 0 0 1 0 0 0 0 0;
               1 1 1 0 0 0 0 0 0;
               1 0 1 0 0 1 1 1 0;
               1 0 0 1 0 1 0 0 0;
               1 1 1 0 0 1 0 0 0]; % Brown
            
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
xlim([0 9]);

end