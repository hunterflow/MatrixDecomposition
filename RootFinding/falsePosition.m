function [root,fx,ea,iter] = falsePosition(func,x_l,x_u,es,maxiter)
% Created on: March 2, 2019
% By: Hunter Flowers 

% falsePosition - This function uses the false position root finding 
% method to determine the root of a user-entered function.
%    Inputs:
%        func - function in which desired root exists (must enter @(x)
%        prior to entering function)
%        x_l - lower bound of root
%        x_u - upper bound of root
%        es - desired approximate error
%        maxiter - maximum iterations desired
%    Outputs:
%        root - bounded root of desired function
%        fx - function evaluated at root
%        iter - number of iterations before function determined root 
%        ea - approximate percent relative error of root

% Check if lower bound is smaller than upper bound
if x_l > x_u
    error('Upper bound must be greater than lower bound.')
end

% Check if entered bounds have opposite signs
if func(x_l) * func(x_u) > 0
    error('The bounds do not bracket a root. Re-enter bounds that have a sign change.')
end
 
% Check if adequate input values were entered
if nargin < 3
    error('Not enough input arguments.')
end

% Set default inputs if left un-entered
if nargin == 3
    es = 0.0001;
    maxiter = 200;
elseif nargin == 2
    maxiter = 200;
end

% Set initial conditions to run loop
iter = 0;
x_r = x_l;
ea = 10;

% Loop until the approximate relative error (ea) is less than stopping
% criteria (es) or the maximum iterations are reached
while ea >= es && iter < maxiter
    % Establish a previous value so approximate error can be determined
    x_r_prev = x_r;
    x_r = x_u - ((func(x_u)*(x_l - x_u))/(func(x_l) - func(x_u)));
    iter = iter + 1;
    % Change the estimated root to either the upper or lower bound of next
    % iteration
    if func(x_r) > 0
        x_u = x_r;
    else
        x_l = x_r;
    end 
    ea = abs((func(x_r) - func(x_r_prev))/(func(x_r)) * 100);
end
% Produce output values not already determined
root = x_r;
fx = func(root);
end
