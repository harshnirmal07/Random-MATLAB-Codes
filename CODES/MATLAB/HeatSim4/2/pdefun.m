function [c,f,s] = pdefun(X,T,U,DuDx)
    c = 1;
    f = DuDx;
    s = 0;
end