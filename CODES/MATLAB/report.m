X = [0.006,0.025,0.030,0.038];
Y = [1166.67,840,933.33,921.053];
func = @(x,X)x(1)*X + x(2);
x0 = [100,100];
val = lsqcurvefit(func,x0,X,Y);
xmesh = linspace(0,0.05,1000);
ymesh = xmesh*val(1) + val(2);
plot(xmesh,ymesh)
hold on
plot(X,Y,'o');

xlabel('XO - X');
ylabel('T/(XO - X)');
title('XO - X VS T/(XO - X) at 60C');
grid on