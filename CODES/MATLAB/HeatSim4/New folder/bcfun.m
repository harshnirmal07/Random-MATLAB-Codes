function [pl, ql, pr, qr] = bcfun(xl, ul, xr, ur, t)
    Bi = 10; % Define the Biot number here
    pl = 0;
    ql = 1;
    pr = -Bi * ur;
    qr = 1;
end
