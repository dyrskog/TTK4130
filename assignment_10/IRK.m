function x = IRK(ButcherArray, f, dfdx, T, x0)
    % Returns the iterations of an IRK method using Newton's method
    % ButcherArray: Struct with the IRK's Butcher array
    % f: Function handle
    %    Vector field of ODE, i.e., x_dot = f(t,x)
    % dfdx: Function handle
    %       Jacobian of f w.r.t. x
    % T: Vector of time points, 1 x Nt
    % x0: Initial state, Nx x 1
    % x: IRK iterations, Nx x Nt
    Nt = length(T);
    Nx = length(x0);
    dT = diff(T);
    x = zeros(Nx,Nt);
    x(:,1) = x0;
    A = ButcherArray.A;
    b = ButcherArray.b(:);
    c = ButcherArray.c(:);
    Nstage = size(A,1);
    xt = x0;
    k = repmat(f(T(1),x0),Nstage,1); % initial guess
    for nt=2:Nt
        t = T(nt-1);
        dt = dT(nt-1);
        g = @(k) IRKODEResidual(k,xt,t,dt,A,c,f);
        G = @(k) IRKODEJacobianResidual(k,xt,t,dt,A,c,dfdx);
        k = NewtonsMethod(g,G,k);
        K = reshape(k,Nx,Nstage);
        xt = xt + dt*(K*b);
        x(:,nt) = xt;
    end
end
function g = IRKODEResidual(k,xt,t,dt,A,c,f)
    Nx = length(xt);
    Nstage = size(A,1);
    K = reshape(k,Nx,Nstage);
    Tg = t+dt*c';
    Xg = xt+dt*K*A';
    g = reshape(K-f(Tg,Xg),[],1);
end
function G = IRKODEJacobianResidual(k,xt,t,dt,A,c,dfdx)
    Nx = length(xt);
    Nstage = size(A,1);
    K = reshape(k,Nx,Nstage);
    TG = t+dt*c';
    XG = xt+dt*K*A';
    dfdxG = cell2mat(arrayfun(@(i) dfdx(TG(:,i),XG(:,i))',1:Nstage,...
        'UniformOutput',false))';
    G = eye(Nx*Nstage)-repmat(dfdxG,1,Nstage).*kron(dt*A,ones(Nx));
end