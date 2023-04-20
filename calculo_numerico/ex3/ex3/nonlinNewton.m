function N = nonlinNweton(F,J,X0,tol,nmax)
    syms X;
    J = J(F,X);
    N = nmax;
    e = tol;
    xi = X0; 
    for i = 1 : N 
        j = subs(J,v,xi);
        fx = subs(F,v,xi);
        xt = xi - j^(-1)*fx;
        if(max(abs(xt-xi))<e)
            xi = xt;
        break;
    end
end
