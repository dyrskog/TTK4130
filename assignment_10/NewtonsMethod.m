function x = NewtonsMethod(f,J,x0,tol,N)
% If N, tol are not stated in the input, the method will use
% default values for these variables. 
% f: function to find root of.
% J: Jacobian of f wrt. unknowns. 
% x0: initial guess of root.
    if nargin < 5
        N = 100;
    end
    if nargin < 4
        tol = 1e-6;
    end
    x = x0;
    n = 1;
    fx = f(x);    
    iterate = norm(fx,Inf) > tol;
    while iterate
        x = x - J(x)\fx;
        n = n+1;
        fx = f(x);
        iterate = norm(fx,Inf) > tol && n <= N;
    end
end