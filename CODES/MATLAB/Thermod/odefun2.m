function dydt = odefun2(t,y)
eq(1) = y(2);
eq(2) = 6*t;

dydt = [eq(1);eq(2)];

end

