function y = Pool(x)
    % This function takes the feature map and returns the image
    %after the 2x2 mean pooling process.

    [xrow, xcol, numFilters] = size(x);
    %y = zeros(size(x));
    y = zeros(xrow/2, xcol/2, numFilters);
    for k = 1:numFilters
        filter = ones(2)/(2*2); % for mean
        image = conv2(x(:,:,k), filter, 'valid');
        y(:,:,k) = image(1:2:k, 1:2:k);
    end
end