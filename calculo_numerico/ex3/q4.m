%%% 
% Joao Victor Colombari Carlet
% Exercicios lista 3
% Questao 04
%%%


% Critério de parada de norm(deltax) < 1E-8

% Crie uma função Jac que retorne a matriz Jacobiana 
% do problema para um dado x de entrada

% def: function x = nonlinNewton(fun,Jac,x0,tol,nmax) 

% exe: x = nonlinNewton(@fun,@Jac,x0,1E-8,1000)

clear all

%% d(f1)/dx1 d(f1)/dx2 . . . d(f1)/dxn;
%  d(f2)/dx1 d(f2)/dx2 . . . d(f2)/dxn;
%  .    .
%  .            .
%  .                    .
%  d(fn)/dx1 d(fn)/dx2 . . . d(fn)/dxn;

syms x1 x2 x3;

X=[x1 x2 x3];

F=@vector_function;

% Funcao J que retorna a matriz Jacobiana para as variaveis
J=@(F,X)[[diff(F(X),X(1)); diff(F(X),X(2)); diff(F(X),X(3))].']; 


