clear all 

freq=[20 50.05 70 100 200 500.5 700 1000 2000 2122 5000 7000 10000 20000];

test_c1=[39.2 36.8 34.4 26.8 15.2 7.8 6.8 5.84 4.64 4.56 2.72 2.20 1.64 0.78]
Result=[53.8039 53.2552 52.6694 50.5009 45.5751 39.7801 38.5884 37.2665 35.2686 35.1175 30.6296 28.7867 26.2351 19.7801]
test_c2=[34.4 32.8 31.2 24.4 13.6 7.4 6.20 5.52 4.48 4.32 2.64 2.00 1.36 0.76]

% tudo isso dos testes est� em volt pra uma referencia de 68mV

Certo=[19.274 16.941 15.283 13.088 8.219 2.643 1.234 0 -2.589 -2.866 ...
    -8.210 -10.816 -13.734 -19.620];
    
% Result=[76.3313 73.9022 72.1889 69.9469 65.0355 59.47 58.0645 56.8372 ...
%     54.252 53.9741 48.6263 46.0188 43.0962 37.1963]; obs: primeira pcb

% Result=[76.3499 73.9664 72.272 70.0444 65.1372 59.5317 58.1063 56.862...
%     54.2592 53.9805 48.6274 46.0194 43.0965 37.1964];

% Result=[76.386 73.960 72.254 70.019 65.109 59.521 58.105 56.8679 54.272 53.994 ... 
%     48.642 46.034 43.111 37.211];

% Result=[76.475 74.409 72.860 70.759 65.991 60.464 59.062 57.842 55.296 ...
%     55.026 49.727 47.131 44.214 38.319];


diff=[];
diffpc=[];

[~,zero]=(min(abs(Certo - 0)));
zero=Result(zero);

for i=1:length(Result)
    Result(i)=Result(i)-zero;
    diff(i)=abs(Certo(i)-Result(i));
    diffpc(i)=(abs(diff(i)/Certo(i)))*100;
end

diffpc
 