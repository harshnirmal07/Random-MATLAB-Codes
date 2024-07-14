

%%boundary value problem
xmesh = [0:1/100:1]
solinit = bvpinit(xmesh,[0;0]);

sol = bvp4c(@odefun2,@bcfun,solinit)

main_sol = sol.y
main_sol_y = main_sol(1,:);

plot(xmesh,main_sol_y)