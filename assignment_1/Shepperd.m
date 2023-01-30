function [theta, k] = Shepperd(R)
    syms z0 z1 z2 z3

    z = [z0 z1 z2 z3];
    
    % Equation 6.223-6.225
    eq1 = z0*z1 == R(3,2) - R(2,3);
    eq2 = z0*z2 == R(1,3) - R(3,1);
    eq3 = z0*z3 == R(2,1) - R(1,2);
    eq4 = z2*z3 == R(3,2) + R(2,3);
    eq5 = z3*z1 == R(1,3) + R(3,1);
    eq6 = z1*z2 == R(2,1) + R(1,2);

    eq = [eq1 eq2 eq3 eq4 eq5 eq6];

    % Find zi
    Ri = [trace(R) R(1,1) R(2,2) R(3,3)];
    [rii,i] = max(Ri);
    zi = sqrt(1 + 2*rii - trace(R));

    % Substitute zi into the equations and solve for remaining zj
    eq = subs(eq, z(i), zi);
    sol = solve(eq, z);

    % Make array with solutions and insert zi
    solz = [sol.z0 sol.z1 sol.z2 sol.z3]; 
    solz(i) = zi;

    % Convert to euler parameters
    eta = solz(1)/2;
    epsilon = [solz(2:end)]/2;

    % Convert to angle axis
    theta = acos(eta)*2;
    k = epsilon/sin(theta/2);
end