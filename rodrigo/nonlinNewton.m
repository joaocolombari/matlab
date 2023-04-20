%%%----------------------------- item (d) -----------------------------------%%%
function [x res] = nonlinNewton(fun,Jac,x0,tol,nmax)

res = 1;  % inicializa o residuo para entrar no loop
k   = 0;  % inicializa a variavel para contagem das interacoes
xk  = x0; % valor de x na iteracao (k)

while res > tol && k < nmax

J     =  Jac(xk);
f     =  fun(xk);

deltax = -J\f;         % resolve o sistema linear J(xk)*deltax = -f(xk)
xkp1    = xk + deltax; % calcula x na iteracao (k+1)

res = norm(deltax);    % calcula o residuo
k   = k+1;             % atualiza o numero de iteracoes

xk  = xkp1;            % atualiza o valor de xk para a proxima iteracao

end

x = xk;

end
%%%--------------------------------------------------------------------------%%%
