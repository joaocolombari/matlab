function B = B(Hc)

global N;  global lc; global lg; global I;  global mu0;


B=(-lc*mu0.*Hc/(2*lg) + N*I*mu0/(2*lg));
end