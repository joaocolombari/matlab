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
xlim([0 7]);
    
%output images
subplot(1,2,2);
idx = find(y == max(y));
if idx == 1
    fig_out = [0 0 0 1 0 0 0;
               0 0 1 1 1 0 0;
               0 1 1 1 1 1 0;
               1 1 1 1 1 1 1;
               0 1 1 1 1 1 0;
               0 0 1 1 1 0 0;
               0 0 0 1 0 0 0]; % Orange Rhombus (1st set)
elseif idx == 2
    fig_out = [0 0 0 0 0 0 0;
               0 0 0 0 0 0 0;
               0 0 0 1 0 0 0;
               0 0 1 1 1 0 0;
               0 1 1 1 1 1 0;
               1 1 1 1 1 1 1;
               0 0 0 0 0 0 0]; % Blue Triangle (1st set)
elseif idx == 3
    fig_out = [0 0 1 1 1 0 0;
               0 1 1 1 1 1 0;
               1 1 1 1 1 1 1;
               1 1 1 1 1 1 1;
               1 1 1 1 1 1 1;
               0 1 1 1 1 1 0;
               0 0 1 1 1 0 0]; % Black Circle (1st set)
elseif idx ==4
    fig_out = [1 1 0 0 0 1 1;
               1 0 0 0 0 0 1;
               0 0 0 0 0 0 0;
               0 0 0 0 0 0 0;
               0 0 0 0 0 0 0;
               1 0 0 0 0 0 1;
               1 1 0 0 0 1 1]; % Green Circle (2nd set)

elseif idx ==5
    fig_out = [1 1 1 1 1 1 1;
               1 0 0 0 0 0 1;
               1 0 0 0 0 0 1;
               1 0 0 0 0 0 1;
               1 0 0 0 0 0 1;
               1 0 0 0 0 0 1;
               1 1 1 1 1 1 1]; % Pink Square (2nd set)
elseif idx ==6
    fig_out = [1 1 1 1 1 1 1;
               1 1 1 1 1 1 1;
               0 0 0 0 0 0 0;
               0 0 0 0 0 0 0;
               0 0 0 0 0 0 0;
               1 1 1 1 1 1 1;
               1 1 1 1 1 1 1]; % Yellow Rectangle (2nd set)

    else
    fig_out = [1 1 1 1 1 1 1;
               1 1 1 1 1 1 1;
               1 1 1 0 1 1 1;
               1 1 0 0 0 1 1;
               1 0 0 0 0 0 1;
               0 0 0 0 0 0 0;
               1 1 1 1 1 1 1]; % Blue Triangle (2st set)
            
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
xlim([0 7]);

end