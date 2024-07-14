function [c, f, s] = pdefun(x, t, u, DuDx)
    c = 1;
    f = DuDx;
    s = 0;
end
